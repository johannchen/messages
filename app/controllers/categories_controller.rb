class CategoriesController < ApplicationController
  def index
    @category = Category.new
    if params[:term]
      # jquery autocomplete
      @categories = Category.where("name like ?", "%#{params[:term]}%")
    else
      @categories = Category.all
    end
    respond_to do |format|
      format.html
      format.json { render :json => @categories.order(:name).map(&:name) }
    end
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
