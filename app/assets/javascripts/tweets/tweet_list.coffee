class CT.TweetList

  init: ->
    new CT.TweetEdit()
    new CT.TweetComment(@onstartComment.bind(@))
    @viewCommentsToggle = new CT.ViewCommentToggle()

  onstartComment: ($buttonElement) ->
    @viewCommentsToggle.toggleExpandComments($buttonElement, true)
