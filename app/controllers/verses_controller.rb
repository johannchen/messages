class VersesController < ApplicationController
  load_and_authorize_resource

  def index 
    @verse = Verse.new
    @categories = current_user.categories.order(:name)
    
    if params[:view]
      vs = current_user.verses
    else
      vs = current_user.verses.favorites
    end

    @count = vs.count

    if params[:cat] && params[:book]
      vs = vs.book(params[:book]).joins(:categories).where(:categories => {:id => params[:cat]})
    elsif params[:cat]
      vs = vs.joins(:categories).where(:categories => {:id => params[:cat]})
    elsif params[:book]
      vs = vs.book(params[:book])
    end

    @verses = vs.order("updated_at DESC").page(params[:page]).per(10)
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    params[:verse][:favorite] = 1 unless params[:verse][:favorite]
    # handle mobile select 
    params[:verse][:ref] = params[:verse_book] + " " + params[:verse_num] if params[:verse_book]
    @verse = current_user.verses.build(params[:verse])
    if @verse.save
      respond_to do |format|
        format.mobile { redirect_to @verse }
        format.html { redirect_to verses_path, notice: 'Successfully added verse.' }
      end
    else 
      render 'new'
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
end
