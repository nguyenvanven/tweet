RSpec.describe TweetServices::Search do
  before do
    @tweet1 = CustomTweet.create({ content: 'test1' })
    @tweet2 = CustomTweet.create({ content: 'test2' })
    @tweet3 = CustomTweet.create({ content: 'test3' })
    @tweet4 = CustomTweet.create({ content: 'test3' })
  end

  describe 'Test paging correctly' do
    describe 'Test query first page limit 1' do
      it 'should return tweet 1 only' do
        tweets = TweetServices::Search.new(page: 1, item_per_page: 1).()
        expect(tweets.size).to eq 1
        expect(tweets.first.id).to eq @tweet1.id
      end
    end

    describe 'Test query second page limit 1' do
      it 'should return tweet 2 only' do
        tweets = TweetServices::Search.new(page: 2, item_per_page: 1).()
        expect(tweets.size).to eq 1
        expect(tweets.first.id).to eq @tweet2.id
      end
    end

    describe 'Test query first page limit 2' do
      it 'should return 2 tweets (1 and 2)' do
        tweets = TweetServices::Search.new(page: 1, item_per_page: 2).()
        expect(tweets.size).to eq 2
        expect(tweets.map(&:id)).to match_array [@tweet1.id, @tweet2.id]
      end
    end

    describe 'Test query second page limit 2' do
      it 'should return 2 tweets (3 and 4)' do
        tweets = TweetServices::Search.new(page: 2, item_per_page: 2).()
        expect(tweets.size).to eq 2
        expect(tweets.map(&:id)).to match_array [@tweet3.id, @tweet4.id]
      end
    end

    describe 'Test query page smaller than 1' do
      it 'should return page 1' do
        tweets = TweetServices::Search.new(page: -1, item_per_page: 1).()
        expect(tweets.size).to eq 1
        expect(tweets.first.id).to eq @tweet1.id
      end
    end

    describe 'Test query page over limit of 4 pages (per_page = 1)' do
      it 'should return empty' do
        tweets = TweetServices::Search.new(page: 5, item_per_page: 1).()
        expect(tweets.size).to eq 0
      end
    end
  end

  describe 'Test tweet search relations' do
    it 'Should query tweet with no parents only' do
      child_tweet = CustomTweet.create({ content: 'test child', parent_tweet_id: @tweet1.id })
      tweets = TweetServices::Search.new(page: 1, item_per_page: 100).()
      expect(tweets.map(&:id)).not_to include child_tweet.id
    end
  end
end
