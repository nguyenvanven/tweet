module TweetServices
  class Delete
    def initialize(custom_tweet)
      @custom_tweet = custom_tweet
    end

    def call
      return unless @custom_tweet.present?
      @custom_tweet.destroy
    end
  end
end
