# frozen_string_literal: true

class HomeController < ApplicationController
  before_action { @page_title = 'Home' }

  TWEETS_DISPLAY_AMOUNT = 10

  def index
    @tweets = TweetServices::MostCommentedTweets.new(TWEETS_DISPLAY_AMOUNT).()
  end
end
