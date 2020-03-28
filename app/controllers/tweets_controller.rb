class TweetsController < ApplicationController
  before_action { @page_title = 'Tweet' }

  def index
  end

  def new
    @tweet = CustomTweet.new
  end

  def create
    service = TweetServices::Creation.new(creation_params)
    if service.valid?
      created_tweet = service.()
      respond_to do |format|
        flash[:success] = 'Tweet saved!'
        format.html do
          redirect_to tweet_path(created_tweet)
        end
        format.json do
          render json: created_tweet
        end
      end
    else
    end
  end

  def show
    @tweet = CustomTweet.find(params[:id])
  end

  def update
    debugger
    service = TweetServices::Update.new(custom_tweet, update_params)
    if service.valid?
      updated_tweet = service.()
      render json: updated_tweet
    else
      render json: {errors: service.errors.flatten.join(',')}, status: :unprocessable_entity
    end
  end

  private

  def custom_tweet
    @custom_tweet ||= CustomTweet.find(params[:id])
  end

  def creation_params
    params.require(:custom_tweet).permit(:content, :parent_tweet_id)
  end

  def update_params
    params.require(:custom_tweet).permit(:content)
  end
end
