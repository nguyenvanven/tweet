class CT.TweetEdit
  selectors = {
    tweetContent: '.js-tweetContent'
    tweetEditToggle: '.js-editTweet'
    textBlock: '.js-textContentBlock'
    editBlock: '.js-editTweetBlock'
    cancelEditBtn: '.js-cancelTweet'
    saveEditBtn: '.js-saveTweet'
    editContentNode: '.js-tweetContentEdit'
    tweetEditTextArea: '.js-tweetEditArea'
    tweetTextContent: '.js-tweetTextContent'
  }

  constructor: ->
    @bindEvents()

  bindEvents: ->
    @bindTweetEditClickEvent()
    @bindCancelEditTweetEvent()
    @bindSaveEditTweetEvent()

  bindTweetEditClickEvent: ->
    self = @
    $(selectors.tweetEditToggle).on 'click', (evt) ->
      evt.preventDefault()
      self.toggleEdit($(@), true)

  bindCancelEditTweetEvent: ->
    self = @
    $(selectors.cancelEditBtn).on 'click', (evt) ->
      evt.preventDefault()
      $this = $(@)
      self.toggleEdit($this, false)
      self.resetTextArea($this)

  resetTextArea: ($currentContent) ->
    $tweetElement = @findContentElement($currentContent)
    originalTweet = $tweetElement.find(selectors.tweetTextContent).text()
    $tweetElement.find(selectors.tweetEditTextArea).val(originalTweet)

  toggleEdit: ($currentContent, isEditable) ->
    parent = @findContentElement($currentContent)
    parent.find(selectors.editBlock).toggleClass('hidden', !isEditable)
    parent.find(selectors.textBlock).toggleClass('hidden', isEditable)

  findContentElement: ($currentContent) ->
    $currentContent.parents(selectors.tweetContent)

  bindSaveEditTweetEvent: ->
    self = @
    $(selectors.saveEditBtn).on 'click', (event) ->
      event.preventDefault()
      self.saveTweet($(@))

  saveTweet: ($currentContent) ->
    $editNode = $currentContent.parents(selectors.editContentNode)
    id = $editNode.data('id')
    url = "/tweets/#{id}"
    tweetContent = $editNode.find(selectors.tweetEditTextArea).val()
    data = {
      custom_tweet: {
        content: tweetContent
      }
    }
    self = @
    successCB = (response) ->
      self.findContentElement($currentContent).find(selectors.tweetTextContent).text(response.content)
      self.toggleEdit($currentContent, false)
    failedCb = (response) ->
      alert("Error when save: #{response.errors}")

    CT.Utils.sendToServer(url, 'PUT', data, successCB, failedCb)
