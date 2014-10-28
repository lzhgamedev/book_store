class CategoriesController < ApplicationController
  def index
    @categories = Category.order(:display_order)
  end
end
