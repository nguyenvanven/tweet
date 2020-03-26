module TweetServices
  class Update
    attr_reader :errors
    ALLOWED_UPDATE_PARAMS = [:content]

    def initialize(custom_tweet, update_params)
      @custom_tweet = custom_tweet
      @update_params = update_params
      assign_update_attributes
      @errors = []
    end

    def valid?
      if @custom_tweet.blank?
        @errors << ['Tweet is not found to update']
        return false
      end

      unless @custom_tweet.valid?
        @errors << @custom_tweet.errors.full_messages
        return false
      end
      true
    end

    def call
      return unless valid?
      @custom_tweet.save!
    end

    private

    def assign_update_attributes
      return unless @custom_tweet.present?
      @custom_tweet.assign_attributes(allowed_params)
    end

    def allowed_params
      @allowed_params ||= @update_params.slice(*ALLOWED_UPDATE_PARAMS)
    end
  end
end
