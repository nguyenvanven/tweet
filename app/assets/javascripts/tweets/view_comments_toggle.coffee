class CT.ViewCommentToggle
  selectors = {
    tweetDetail: '.js-tweetDetail'
    childrendSummary: '.js-tweetDetail__childSum'
    viewCommentsToggle: '.js-tweetDetail__childSum-toggle'
    tweetChildren: '.js-tweetChildren'
  }

  EXPANDED_CLASS = 'is-expanded'

  constructor: ->
    @bindEvents()

  bindEvents: ->
    @bindExpandChildrenEvent()

  bindExpandChildrenEvent: ->
    self = @
    $(selectors.viewCommentsToggle).on 'click', (evt) ->
      evt.preventDefault()
      $toggler = $(@)
      self.toggleExpandComments($toggler, !self.isCommentExpanded($toggler))

  toggleExpandComments: ($toggler, isExpanded) ->
    $parentNode = $toggler.parents(selectors.tweetDetail).eq(0)
    $parentNode.find(selectors.tweetChildren).toggleClass(EXPANDED_CLASS, isExpanded)

  isCommentExpanded: ($toggler) ->
    $parentNode = $toggler.parents(selectors.tweetDetail).eq(0)
    $parentNode.find(selectors.tweetChildren).hasClass(EXPANDED_CLASS)
