RSpec.describe TweetServices::Delete do
  before do
    @tweet = CustomTweet.create({ content: 'parent' })
  end

  describe 'Test Delete tweet' do
    describe 'delete tweet' do
      it 'Should delete tweet' do
        TweetServices::Delete.new(@tweet)
        expect(CustomTweet.exists?(@tweet.id)).to be false
      end
    end
  end
end
