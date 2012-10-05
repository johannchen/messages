class MessagesController < ApplicationController
  load_and_authorize_resource

  def index
    @speakers = current_user.speakers.order(:name)
    @categories = current_user.categories.order(:name)
    @verses = current_user.verses

    @messages = current_user.messages.order("updated_at DESC")

    respond_to do |format|
      format.html
      format.json
      format.csv { render :text => current_user.messages.download_csv }
    end
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @message = current_user.messages.build(params[:message])
    respond_to do |format|
      if @message.save
        format.json { render json: @message, status: :created }
      else
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.json { head :no_content }
      else
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def note
    @message = Message.find(params[:id])
  end

  def calendar
    @messages = current_user.messages
    messages = []
    @messages.each do |message|
      messages << {:id => message.id, :title => message.title, :start => message.listened_on, :allDay => true}
    end
    render :text => messages.to_json
  end

  def remove_verse
    @message = Message.find(params[:id])
    verse = Verse.find(params[:verse])
    if @message.verses.delete(verse)
      redirect_to :back
    else
      redirect_to :back, notice: "Cannot remove verse."
    end
  end

  def add_verse
    @message = Message.find(params[:id])
    verse = Verse.find_or_create_by_ref_and_user_id(params[:ref], current_user)
    @message.verses <<  verse
    redirect_to @message 
  end
end
