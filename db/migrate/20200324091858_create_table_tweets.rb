class CreateTableTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :custom_tweets do |t|
      t.integer :parent_tweet_id
      t.integer :children_tweet_count, default: 0
      t.string :content

      t.timestamps
    end
  end
end
