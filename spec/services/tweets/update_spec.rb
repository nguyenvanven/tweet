
RSpec.describe TweetServices::Update do
  before do
    @tweet = CustomTweet.create({ content: 'parent' })
  end

  describe 'Validate update' do
    describe 'Empty prarameter passed' do
      it 'Should pass validation' do
        service = TweetServices::Update.new(@tweet, {})

        expect(service.valid?).to be true
      end
    end

    describe 'Empty content passed' do
      it 'Should fail validation' do

        service = TweetServices::Update.new(@tweet, { content: '' })

        expect(service.valid?).to be false
        expect(service.errors).to match_array [["Content can't be blank"]]
      end
    end

    describe 'Not empty content passed' do
      it 'Should pass validation' do

        service = TweetServices::Update.new(@tweet, { content: 'valid content' })

        expect(service.valid?).to be true
      end
    end

    describe 'nil tweet passed' do
      it 'Should fail validation' do
        service = TweetServices::Update.new(@tweet, { content: 'valid content' })

        expect(service.valid?).to be false
        expect(service.errors).to match_array [['Tweet is not found to update']]
      end
    end
  end

  describe 'Update tweet' do
    describe 'Update invalid tweet' do
      it 'should not update tweet' do
        old_content = @tweet.content

        TweetServices::Update.new(@tweet, { content: '' }).()

        expect(@tweet.reload.content).to eq old_content
      end
    end

    describe 'Update tweet valid content' do
      it 'should be able to update content' do
        new_valid_content = 'new valid content'

        TweetServices::Update.new(@tweet, { content: new_valid_content }).()

        expect(@tweet.reload.content).to eq new_valid_content
      end
    end

    describe 'Update children_tweet_count' do
      it 'should not able to update children_tweet_count' do
        old_children_tweet_count = @tweet.children_tweet_count

        TweetServices::Update.new(@tweet, { children_tweet_count: 100 }).()

        expect(@tweet.reload.children_tweet_count).to eq old_children_tweet_count
      end
    end
  end
end
