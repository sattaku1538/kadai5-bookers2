class FavoritesController < ApplicationController
  def create
    book = Book.find(params[:post_image_id])
    favorite = current_user.favorites.new(user_id: user.id)
    favorite.save
    # redirect_to user_path(user_image)
  end

  def destroy
    book = Book.find(params[:post_image_id])
    favorite = current_user.favorites.find_by(user_id: user.id)
    favorite.destroy
    # redirect_to user_path(user_image)
  end
end
