class CategoriesController < ApplicationController
  before_action :set_current_user

  def new
  end

  def index
    @categories = Category.all
  end
end
