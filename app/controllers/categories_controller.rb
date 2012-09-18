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
      cats = current_user.categories
      @count = cats.count
      @categories = cats.order(:name).paginate(page: params[:page], per_page: 30) 
    end
    respond_to do |format|
      format.html
      format.json { render json: @categories.order(:name), only: [:id, :name] }
    end
  end

  def show
    @verses = @category.verses.favorites.order("updated_at DESC")
    respond_to do |format|
      format.html
      format.json { render json: @category, only: [:id, :name] }
    end
  end

  def new
  end

  def edit
  end

  def create
    @category = current_user.categories.build(params[:category])
    if @category.save
      # redirect_to categories_path, notice: 'Successfully added category.'
      respond_to do |format|
        format.json { render json: @category, status: :created }
      end
    else
      respond_to do |format|
        format.json { render json: @category.errors, status: :unprocessable_entity }
        format.mobile { render 'new', notice: 'Category name cannot be blank or duplicated' }
        format.html { redirect_to categories_path, notice: 'Category name is required.' }
      end
    end
  end

  def update
    if @category.update_attributes(params[:category])
      #redirect_to categories_path, notice: 'Successfully updated category.'
      respond_to do |format|
        format.json { head :no_content }
      end
    else
      #render action: "edit"
      respond_to do |format|
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy
    # redirect_to categories_path
    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
