class TweetsController < ApplicationController
  before_action { @page_title = 'Tweet' }

  DEFAULT_PER_PAGE = 10;
  FIRST_PAGE = 1;

  def index
    @page = (params[:page] || FIRST_PAGE).to_i
    @item_per_page = (params[:per_page] || DEFAULT_PER_PAGE).to_i
    service = TweetServices::Search.new(page: @page, item_per_page: @item_per_page)
    @tweets = service.()
    @total_items = service.total_items
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

        format.text do
          render template: 'tweets/_tweet_detail.html.haml', locals: { tweet: created_tweet, expand_children: true }, layout: false
        end
      end
    else
      errors = build_return_errors_for(service.errors)
      respond_to do |format|
        flash[:error] = 'Tweet saved!'
        format.html do
          redirect_to tweet_path(created_tweet)
        end

        format.text do
          render text: errors, status: :unprocessable_entity
        end
      end
    end
  end

  def show
    @tweet = CustomTweet.preload(:child_tweets).find(params[:id])
  end

  def update
    service = TweetServices::Update.new(custom_tweet, update_params)
    if service.valid?
      updated_tweet = service.()
      render json: updated_tweet
    else
      render json: {errors: build_return_errors_for(service.errors)}, status: :unprocessable_entity
    end
  end

  def destroy
    TweetServices::Delete.new(custom_tweet).()
    render json: {}
  end

  private

  def build_return_errors_for(errors)
    errors.flatten.join(',')
  end

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
