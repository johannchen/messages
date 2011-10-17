class VersesController < ApplicationController
  load_and_authorize_resource

  def index 
    @verse = Verse.new
    @categories = current_user.categories

    if params[:cat]
      @verses = @categories.find(params[:cat]).verses.favor
    elsif params[:book]
      @verses = current_user.verses.favor.where("ref like ?", "%#{params[:book]}%")
    elsif params[:view]
      @verses = current_user.verses
    else
      @verses = current_user.verses.favor
    end
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @verse = current_user.verses.build(params[:verse])
    if @verse.save
      redirect_to verses_path, notice: 'Successfully added verse.'
    end
  end

  def update
    if @verse.update_attributes(params[:verse])
      redirect_to verses_path, notice: 'Successfully updated verse.'
    else
      render action: "edit"
    end
  end

  def destroy
    @verse.destroy
    redirect_to verses_url
  end

  def dislike 
    @verse = Verse.find(params[:id])
    if @verse.update_attribute :favor, false
      redirect_to :back 
    else
      redirect_to :back, :notice => "Cannot remove from favor list"
    end
  end

  def like 
    @verse = Verse.find(params[:id])
    if @verse.update_attribute :favor, true
      redirect_to :back
    else
      redirect_to :back, :notice => "Cannot add to favor list"
    end
  end
end
