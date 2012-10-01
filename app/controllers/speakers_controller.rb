class SpeakersController < ApplicationController
  load_and_authorize_resource
  def index
    @speakers = current_user.speakers.order(:name)
    respond_to do |format|
      format.json { render json: @speakers, only: [:id, :name] }
    end
  end

  def create
    @speaker = current_user.speakers.build(params[:speaker])
    if @speaker.save
      respond_to do |format|
        format.json { render json: @speaker, status: :created }
      end
    else
      respond_to do |format|
        format.json { render json: @speaker.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @speaker.update_attributes(params[:speaker])
      respond_to do |format|
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.json { render json: @speaker.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @speaker.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
