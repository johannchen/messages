class VersesController < ApplicationController
  load_and_authorize_resource

  def index 
    @verse = Verse.new
    @categories = current_user.categories.order(:name)
    @verses = current_user.verses.favorites.order("updated_at DESC")
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @verse }
    end
  end

  def new
  end

  def edit
  end

  def create
    @verse = current_user.verses.build(params[:verse])
    if @verse.save
      respond_to do |format|
        format.json { render json: @verse, status: :created }
      end
    else 
      respond_to do |format|
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @verse.update_attributes(params[:verse])
      # redirect_to verses_path, notice: 'Successfully updated verse.'
      respond_to do |format|
        format.json { head :no_content }
      end
    else
      #render action: "edit"
      respond_to do |format|
        format.json { render json: @verse.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @verse.destroy
    # redirect_to verses_url
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def dislike 
    @verse = Verse.find(params[:id])
    if @verse.update_attribute :favorite, false
      redirect_to :back 
    else
      redirect_to :back, :notice => "Cannot remove from favorite list"
    end
  end

  def like 
    @verse = Verse.find(params[:id])
    if @verse.update_attribute :favorite, true
      redirect_to :back
    else
      redirect_to :back, :notice => "Cannot add to favorite list"
    end
  end

  def api
    @verse = Verse.esv_api(params[:passage])
    respond_to do |format|
      format.json { render json: @verse }
    end
  end
end
