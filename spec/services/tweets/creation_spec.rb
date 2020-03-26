require 'rails_helper'

RSpec.describe TweetServices::Creation do
  describe 'Validate creation Tweet' do
    describe 'Empty prarameter passed' do
      it 'Should be failed validation' do
        service = TweetServices::Creation.new({})

        expect(service.valid?).to be false
        expect(service.errors).to match_array [["Content can't be blank"]]
      end
    end

    describe 'Content empty passed' do
      it 'Should fail validation' do
        service = TweetServices::Creation.new({content: ''})

        expect(service.valid?).to be false
        expect(service.errors).to match_array [["Content can't be blank"]]
      end
    end

    describe 'content is not empty' do
      it 'should pass validation' do
        expect(TweetServices::Creation.new({content: 'test'}).valid?).to be_truthy
      end
    end
  end

  describe 'Create tweet' do
    describe 'Create tweet when validation fail by empty params' do
      it 'should not create' do

        created_tweet = TweetServices::Creation.new({}).()

        expect(created_tweet).to be nil
      end
    end

    describe 'Create tweet when validation pass' do
      it 'Should create tweet successfully' do

        created_tweet = TweetServices::Creation.new({content: 'test'}).()

        expect(created_tweet).not_to be nil
      end
    end

    describe 'Create tweet no parent' do
      it 'tweet parent is nil' do

        created_tweet = TweetServices::Creation.new({content: 'test'}).()

        expect(created_tweet.try(:parent_tweet)).to eq nil
      end
    end

    describe 'Create tweet with parent' do
      it 'parent should link to the tweet' do
        parent_tweet = CustomTweet.create({ content: 'parent' })

        created_tweet = TweetServices::Creation.new({ content: 'test', parent_tweet_id: parent_tweet.id }).()

        expect(created_tweet.try(:parent_tweet).try(:id)).to eq parent_tweet.id
      end
    end
  end
end
