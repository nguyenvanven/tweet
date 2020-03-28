class CT.TweetComment

  selectors = {
    tweetDetail: '.js-tweetDetail'
    commentToggle: '.js-tweetDetail__commentToggle'
    tweetComment: '.js-commentTweet'
    editContentNode: '.js-tweetContentEdit'
    tweetEditTextArea: '.js-tweetEditArea'
    cancelEditBtn: '.js-cancelTweet'
    saveEditBtn: '.js-saveTweet'
  }

  constructor: ->
    @bindEvents()

  bindEvents: ->
    @bindTweetCommentClickEvent()
    @bindCancelEditTweetEvent()
    @bindSaveEditTweetEvent()

  bindTweetCommentClickEvent: ->
    self = @
    $(selectors.commentToggle).on 'click', (event) ->
      event.preventDefault()
      self.toggleCommentBlock($(@), true)

  bindCancelEditTweetEvent: ->
    self = @
    $(selectors.cancelEditBtn).on 'click', (event) ->
      event.preventDefault()
      self.toggleCommentBlock($(@), false)

  bindSaveEditTweetEvent: ->

  toggleCommentBlock: ($childElement, isShowComment) ->
    tweetId = $childElement.parents(selectors.tweetDetail).data('id')
    newCmtBlock = $(".js-commentTweet--#{tweetId}")
    newCmtBlock.toggleClass('hidden', !isShowComment)
