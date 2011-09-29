class SpeakersController < ApplicationController
  load_and_authorize_resource

  def index
    @speakers = current_user.speakers.where(['name like ?', "%#{params[:term]}%"])
    respond_to do |format|
      format.json { render :json => @speakers.order(:name).map(&:name) }
    end
  end
end
