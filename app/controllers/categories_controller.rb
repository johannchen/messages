class CategoriesController < ApplicationController
  def index
    @category = Category.new
    @categories = Category.all
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_to categories_path, notice: 'Successfully added category.'
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      redirect_to categories_path, notice: 'Successfully updated category.'
    else
      render action: "edit"
    end
  end

end
