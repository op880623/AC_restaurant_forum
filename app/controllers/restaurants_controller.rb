class RestaurantsController < ApplicationController
  before_action :set_restaurant, except: [:index, :feeds]

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

  def favorite
    @restaurant.favorites.create!(user: current_user)
    @restaurant.update_favorites_count
    redirect_back(fallback_location: root_path)
  end

  def unfavorite
    favorites = Favorite.where(restaurant: @restaurant, user: current_user)
    favorites.destroy_all
    @restaurant.update_favorites_count
    redirect_back(fallback_location: root_path)
  end

  def like
    @restaurant.likes.create!(user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def unlike
    likes = Like.where(restaurant: @restaurant, user: current_user)
    likes.destroy_all
    redirect_back(fallback_location: root_path)
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

end
