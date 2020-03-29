module TweetServices
  class Search
    def initialize(page:, item_per_page:)
      @offset = [page - 1, 0].max * item_per_page
      @item_per_page = item_per_page
    end

    def call
      relations.offset(@offset).take(@item_per_page)
    end

    def total_items
      relations.size
    end

    private

    def relations
      CustomTweet.where(parent_tweet_id: nil).order(created_date: :desc)
    end
  end
end
