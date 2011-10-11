class VersesController < ApplicationController
  load_and_authorize_resource

  def index 
    @verse = Verse.new
    @verses = current_user.verses
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
  end

end
