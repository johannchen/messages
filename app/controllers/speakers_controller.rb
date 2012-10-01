class SpeakersController < ApplicationController
  load_and_authorize_resource
  def index
    @speakers = current_user.speakers.order(:name)
    respond_to do |format|
      format.json { render json: @speakers, only: [:id, :name] }
    end
  end
end
