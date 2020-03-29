RSpec.describe TweetServices::MostCommentedTweets do
  before do
    @tweet1 = CustomTweet.create({ content: 'test1', children_tweet_count: 1 })
    @tweet2 = CustomTweet.create({ content: 'test2', children_tweet_count: 1 })
    @tweet3 = CustomTweet.create({ content: 'test3', children_tweet_count: 5 })
    @tweet4 = CustomTweet.create({ content: 'test4', children_tweet_count: 2 })
  end

  describe 'Test query most commented' do
    describe 'Take 1 item' do
      it 'should return tweet 3 only' do
        tweets = TweetServices::MostCommentedTweets.new(1).()
        expect(tweets.size).to eq 1
        expect(tweets.first.id).to eq @tweet3.id
      end
    end

    describe 'Take 3 items' do
      it 'should return tweet 3 and 4' do
        tweets = TweetServices::MostCommentedTweets.new(2).()
        expect(tweets.size).to eq 2
        expect(tweets.map(&:id)).to match_array [@tweet3.id, @tweet4.id]
      end
    end
  end
end
