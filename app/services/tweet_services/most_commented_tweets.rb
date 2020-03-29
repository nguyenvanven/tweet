module TweetServices
  class MostCommentedTweets
    def initialize(limit)
      @limit = limit
    end

    def call
      CustomTweet.where(parent_tweet_id: nil).order(children_tweet_count: :desc).take(@limit)
    end
  end
end
