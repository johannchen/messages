class SpeakersController < ApplicationController
  def index
    @speakers = Speaker.where(['name like ?', "%#{params[:term]}%"])
    respond_to do |format|
      format.json { render :json => @speakers.order(:name).map(&:name) }
    end
  end
end
