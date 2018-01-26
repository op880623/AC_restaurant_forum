class FollowshipsController < ApplicationController

  def create
    @followship = current_user.follows.new(following_id: params[:following_id])

    if @followship.save
      flash[:notice] = "Successfully followed."
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @followship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @followship = current_user.follows.where(following_id: params[:id])
    @followship.destroy_all
    flash[:notice] = "Unfollow now"
    redirect_back(fallback_location: root_path)
  end

end
