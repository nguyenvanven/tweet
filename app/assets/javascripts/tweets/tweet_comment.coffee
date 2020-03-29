class CT.TweetComment

  selectors = {
    tweetDetail: '.js-tweetDetail'
    commentToggle: '.js-tweetDetail__commentToggle'
    tweetComment: '.js-commentTweetBlock'
    editContentNode: '.js-tweetContentEdit'
    tweetEditTextArea: '.js-tweetEditArea'
    cancelEditBtn: '.js-commentTweetBlock .js-cancelTweet'
    saveEditBtn: '.js-commentTweetBlock .js-saveTweet'
  }

  constructor: (startCommentCallback) ->
    @bindEvents()
    @startCommentCallback = startCommentCallback

  bindEvents: ->
    @bindTweetCommentClickEvent()
    @bindCancelEditTweetEvent()
    @bindSaveEditTweetEvent()

  bindTweetCommentClickEvent: ->
    self = @
    $(selectors.commentToggle).on 'click', (event) ->
      event.preventDefault()
      if self.startCommentCallback
        self.startCommentCallback($(@))
      self.toggleCommentBlock($(@), true)

  bindCancelEditTweetEvent: ->
    self = @
    $(selectors.cancelEditBtn).on 'click', (event) ->
      event.preventDefault()
      self.toggleCommentBlock($(@), false)

  bindSaveEditTweetEvent: ->
    self = @
    $(selectors.saveEditBtn).on 'click', (event) ->
      event.preventDefault()
      $editNode = $(@).parents(selectors.editContentNode)
      self.saveTweetComment($editNode)

  saveTweetComment: ($editNode) ->
    url = "/tweets"
    data = @buildSavingData($editNode)
    self = @
    successCB = (response) ->
      self.appendComment(data.custom_tweet.parent_tweet_id, response)
      self.toggleCommentBlock($editNode, false)

    failedCb = (response) ->
      alert("Error when save: #{response}")

    CT.Utils.sendToServer(url, 'POST', data, successCB, failedCb, 'text')

  buildSavingData: ($editNode) ->
    parentId = $editNode.data('parent-id')
    tweetContent = $editNode.find(selectors.tweetEditTextArea).val()
    url = "/tweets"
    {
      custom_tweet: {
        parent_tweet_id: parentId
        content: tweetContent
      }
    }

  appendComment: (parentCommentId, commentContent) ->
    $children = $(".js-tweetChildrenOf-#{parentCommentId}")
    $children.append("<div class='c-tweetDetail__child'>#{commentContent}</div>")

  toggleCommentBlock: ($childElement, isShowComment) ->
    tweetId = $childElement.parents(selectors.tweetDetail).data('id')
    newCmtBlock = $(".js-commentTweet--#{tweetId}")
    newCmtBlock.toggleClass('hidden', !isShowComment)

    textArea = newCmtBlock.find(selectors.tweetEditTextArea)
    if isShowComment
      textArea.focus()
    else
      textArea.val('')

