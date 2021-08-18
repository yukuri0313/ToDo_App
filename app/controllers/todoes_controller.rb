class TodoesController < ApplicationController

  before_action :set_current_user
  
  def new
    @category = Category.new
    4.times { @category.todos.build }
  end

  def create
    @category = Category.new(
      category_params,
    )
    @category.save
    redirect_to("/")
  end

  def edit
    @category = Category.new
    @category.todos.build
    @category_name = Category.find(params[:id])
    @todoes = Todo.where(category_id: @category_name.id)
  end

  def update
    @category = Category.find(params[:id])
    @category.update(update_category_params)
    redirect_to("/categories/index")
  end
  
  private
    def category_params
      params.require(:category).permit(:kind, todos_attributes: [:id, :title, :content, :deadline])
    end

    def update_category_params
      params.require(:category).permit(:kind, todos_attributes: [:title, :content, :deadline])
    end
end
