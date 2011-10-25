class MessagesController < ApplicationController
  load_and_authorize_resource

  def index
    @speakers = current_user.speakers
    @categories = current_user.categories
    @verses = current_user.verses

    messages = current_user.messages.order("updated_at DESC")
    if params[:search]
      messages = current_user.messages.search(params[:search])
    elsif params[:cat] && params[:speaker]
      messages = @categories.find(params[:cat]).messages.where(:speaker_id => params[:speaker])
    elsif params[:cat]
      messages = @categories.find(params[:cat]).messages
    elsif params[:speaker]
      messages = @speakers.find(params[:speaker]).messages
    elsif params[:book]
      verse_ids = @verses.where("ref like ?", "%#{params[:book]}%").map(&:id)
      messages = Message.joins(:verses).where(:verses => {:id => verse_ids}) 
    end

    #pagination
    if params[:view] == "list"
      @messages = messages.page(params[:page]).per(30)
    elsif params[:view] == "calendar"
      @messages = messages
    else
      @messages = messages.page(params[:page]).per(10)
    end

    respond_to do |format|
      format.html
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
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url }
    end
  end

  def calendar
    @messages = current_user.messages
    messages = []
    @messages.each do |message|
      messages << {:id => message.id, :title => message.title, :start => message.listened_on, :allDay => true}
    end
    render :text => messages.to_json
  end
end
