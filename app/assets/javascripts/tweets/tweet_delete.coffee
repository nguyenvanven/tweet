class CT.TweetDelete
  selectors = {
    tweetDetail: '.js-tweetDetail'
    tweetDelete: '.js-deleteTweet'
  }

  constructor: ->
    @bindEvents()

  bindEvents: ->
    @bindTweetDeleteClickEvent()

  bindTweetDeleteClickEvent: ->
    self = @
    $(selectors.tweetDelete).on 'click', (event) ->
      event.preventDefault()
      if confirm("Are you sure you want to delete")
        self.handleDeleteTweet($(@))

  handleDeleteTweet: ($toggler) ->
    id = $toggler.data('id')
    url = "/tweets/#{id}"
    successCB = (response) ->
      $toggler.parents(selectors.tweetDetail).eq(0).remove()

    CT.Utils.sendToServer(url, 'DELETE', {}, successCB, null)
