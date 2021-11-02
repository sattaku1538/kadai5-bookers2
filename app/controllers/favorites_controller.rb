class FavoritesController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    redirect_back(fallback_location: root_path)
  end
  
end

# bookの並びに関する説明
# (book_id: book.id)
# book（位置book.id)→book_idに渡す。



# def create
#     @favorite = current_user.favorites.create(recipe_id: params[:recipe_id])
#     redirect_back(fallback_location: root_path)
#   end

#   def destroy
#     @recipe = Recipe.find(params[:recipe_id])
#     @favorite = current_user.favorites.find_by(recipe_id: @recipe.id)
#     @favorite.destroy
#     redirect_back(fallback_location: root_path)
#   end
