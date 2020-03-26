require 'rails_helper'

RSpec.describe CustomTweet, type: :model do
  describe 'Create children for the tweet affect children_tweet_count test' do
    describe 'Create tweet with one level parents' do 
      it 'Should increase children_tweet_count one unit ' do
        parent_tweet = CustomTweet.create({ content: 'parent' })

        CustomTweet.create({ content: 'test', parent_tweet_id: parent_tweet.id })

        expect(parent_tweet.reload.children_tweet_count).to eq 1
      end
    end

    describe 'Create 2 children for the tweet' do
      it 'Should increase children_tweet_count 2 units' do
        parent_tweet = CustomTweet.create({ content: 'parent' })

        CustomTweet.create({ content: 'test1', parent_tweet_id: parent_tweet.id })
        CustomTweet.create({ content: 'test2', parent_tweet_id: parent_tweet.id })

        expect(parent_tweet.reload.children_tweet_count).to eq 2
      end
    end

    describe 'Create tweet with more than one parent level' do
      it 'all parents children_tweet_count should add 1' do
        parent_level_1 = CustomTweet.create({ content: 'parent_level_1' })
        parent_level_2 = CustomTweet.create({ content: 'parent_level_1', parent_tweet_id:  parent_level_1.id})
        parent_level_1.update_column(:children_tweet_count, 1)
        parent_level_2.update_column(:children_tweet_count, 0)

        CustomTweet.create({ content: 'test', parent_tweet_id: parent_level_2.id })

        expect(parent_level_1.reload.try(:children_tweet_count)).to eq 2
        expect(parent_level_2.reload.try(:children_tweet_count)).to eq 1
      end
    end
  end

  describe 'Delete children for the tweet affect children_tweet_count test' do
    describe 'Delete 1 children of tweet' do
      it 'Should decrease children_tweet_count 1 unit' do
        parent_tweet = CustomTweet.create({ content: 'parent' })
        children_tweet = CustomTweet.create({ content: 'test', parent_tweet_id: parent_tweet.id })
        parent_tweet.update_column(:children_tweet_count, 1)

        children_tweet.destroy

        expect(parent_tweet.reload.children_tweet_count).to eq 0
      end
    end

    describe 'Delete 2 children of tweet' do
      it 'Should decrease children_tweet_count 2 unit' do
        parent_tweet = CustomTweet.create({ content: 'parent' })
        children_tweet_1 = CustomTweet.create({ content: 'test', parent_tweet_id: parent_tweet.id })
        children_tweet_2 = CustomTweet.create({ content: 'test2', parent_tweet_id: parent_tweet.id })
        parent_tweet.update_column(:children_tweet_count, 2)

        children_tweet_1.destroy
        children_tweet_2.destroy

        expect(parent_tweet.reload.children_tweet_count).to eq 0
      end
    end

    describe 'Delete tweet has 2 level of parents' do
      it 'Should decrease children_tweet_count all parents 1 unit' do
        parent_tweet_level_1 = CustomTweet.create({ content: 'parent 1' })
        parent_tweet_level_2 = CustomTweet.create({ content: 'parent 2', parent_tweet_id:  parent_tweet_level_1.id })
        children_tweet = CustomTweet.create({ content: 'test', parent_tweet_id: parent_tweet_level_2.id })
        parent_tweet_level_1.update_column(:children_tweet_count, 2)
        parent_tweet_level_2.update_column(:children_tweet_count, 1)

        children_tweet.destroy

        expect(parent_tweet_level_1.reload.children_tweet_count).to eq 1
        expect(parent_tweet_level_2.reload.children_tweet_count).to eq 0
      end
    end

    describe 'Delete 1 children of tweet has children_tweet_count = 0' do
      it 'Should keep children_tweet_count to 0' do
        parent_tweet = CustomTweet.create({ content: 'parent' })
        children_tweet = CustomTweet.create({ content: 'test', parent_tweet_id: parent_tweet.id })
        parent_tweet.update_column(:children_tweet_count, 0)

        children_tweet.destroy

        expect(parent_tweet.reload.children_tweet_count).to eq 0
      end
    end
  end

  describe 'Update children for tweet not affect children_tweet_count' do
    describe 'Update tweet with parent' do
      it 'Should not affect children_tweet_count' do
        parent_tweet = CustomTweet.create({ content: 'parent' })
        children_tweet = CustomTweet.create({ content: 'test', parent_tweet_id: parent_tweet.id })
        parent_tweet.update_column(:children_tweet_count, 1)

        children_tweet.content = 'New content'
        children_tweet.save!

        expect(parent_tweet.reload.children_tweet_count).to eq 1
      end
    end
  end
end
