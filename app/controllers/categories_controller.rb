class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @category = Category.new
    if params[:term]
      # jquery autocomplete
      @categories = current_user.categories.where("name like ?", "%#{params[:term]}%") if current_user.categories
    elsif mobile_device?
      @categories = current_user.categories.order(:name)
    else
      @categories = current_user.categories.order(:name).page(params[:page]).per(30) 
    end
    respond_to do |format|
      format.html
      format.json { render :json => @categories.order(:name).map(&:name) }
    end
  end

  def show
    @verses = @category.verses.favorite.order("updated_at DESC")
  end

  def edit
  end

  def create
    @category = current_user.categories.build(params[:category])
    if @category.save
      redirect_to categories_path, notice: 'Successfully added category.'
    else
      redirect_to categories_path, notice: 'Category name is required.'
    end
  end

  def update
    if @category.update_attributes(params[:category])
      redirect_to categories_path, notice: 'Successfully updated category.'
    else
      render action: "edit"
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path
  end
end
