class SpeakersController < ApplicationController
  load_and_authorize_resource

  def index
    @speaker = Speaker.new
    if params[:term]
      @speakers = current_user.speakers.where(['name like ?', "%#{params[:term]}%"]) if current_user.speakers
    else
      @speakers = current_user.speakers
    end
    respond_to do |format|
      format.html
      format.json { render :json => @speakers.order(:name).map(&:name) }
    end
  end

  def edit
  end

  def create
    @speaker = current_user.speakers.build(params[:speaker])
    if @speaker.save
      redirect_to speakers_path, notice: 'Successfully added speaker.'
    else
      redirect_to speakers_path, notice: 'Speaker name is required.' 
    end
  end

  def update
    if @speaker.update_attributes(params[:speaker])
      redirect_to speakers_path, notice: 'Successfully updated speaker.'
    else
      render action: "edit"
    end
  end

end
