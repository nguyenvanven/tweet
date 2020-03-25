# == Schema Information
#
# Table name: custom_tweets
#
#  id                   :integer          not null, primary key
#  parent_tweet_id      :integer
#  children_tweet_count :integer          default(0)
#  content              :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class CustomTweet < ActiveRecord::Base
  validates :content, presence: true
  after_create :increse_parents_count
  after_destroy :reduce_parents_count

  belongs_to :parent_tweet, class_name: CustomTweet.name, foreign_key: :parent_tweet_id, optional: true
  has_many :child_tweets, dependent: :destroy, class_name: CustomTweet.name,
            foreign_key: :parent_tweet_id

  def increse_parents_count
    update_count_for(parent_tweet) do |current_count|
      current_count + 1
    end
  end

  def reduce_parents_count
    update_count_for(parent_tweet) do |current_count|
      [current_count - 1, 0].max
    end
  end

  def update_count_for(custom_tweet)
    return if custom_tweet.blank?
    custom_tweet.reload
    updated_count = yield(custom_tweet.children_tweet_count)
    custom_tweet.update_column(:children_tweet_count, updated_count)

    update_count_for(custom_tweet.parent_tweet) do |current_count|
      yield(current_count)
    end
  end
end
