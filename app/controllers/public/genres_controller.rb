class Public::GenresController < ApplicationController
  def show
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @genre_items = Item.where(genre_id: @genre.id).page(params[(:page)])
  end
end
