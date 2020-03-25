module TweetServices
  class Creation
    attr_reader :errors

    def initialize(creation_params)
      @creation_params = creation_params
      @errors = []
    end

    def valid?
      if tweet.valid?
        true
      else
        @errors << tweet.errors.full_messages
        false
      end
    end

    def call
      return unless valid?
      tweet.save!
      tweet
    end

    private

    def tweet
      @tweet ||= CustomTweet.new(@creation_params)
    end
  end
end