class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :dashboard]

  def index
    @restaurants = Restaurant.page(params[:page]).per(9)
    @categories = Category.all
    @category = nil
  end

  def show
    @comment = Comment.new
  end

  def feeds
    @recent_restaurants = Restaurant.order(created_at: :desc).limit(10)
    @recent_comments = Comment.order(created_at: :desc).limit(10)
  end

  def dashboard
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

end
