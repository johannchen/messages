class MessagesController < ApplicationController
  load_and_authorize_resource

  def index
    @speakers = current_user.speakers.order(:name)
    @categories = current_user.categories.order(:name)
    @verses = current_user.verses

    ms = current_user.messages
    ms = ms.search(params[:search]) if params[:search]
    
    if params[:cat] && params[:speaker] && params[:book]
      ms = @categories.find(params[:cat]).messages.where(:speaker_id => params[:speaker]).book(params[:book])
    elsif params[:cat] && params[:speaker]
      ms = @categories.find(params[:cat]).messages.where(:speaker_id => params[:speaker])
    elsif params[:cat] && params[:book]
      ms = @categories.find(params[:cat]).messages.book(params[:book])
    elsif params[:speaker] && params[:book]
      ms = @speaker.find(params[:speaker]).messages.book(params[:book]) 
    elsif params[:cat]
      ms = @categories.find(params[:cat]).messages
    elsif params[:speaker]
      ms = @speakers.find(params[:speaker]).messages
    elsif params[:book]
      ms = ms.book(params[:book])
    end
    
    @count = ms.count

    ms = ms.order("updated_at DESC")

    #pagination
    if params[:view] == "list"
      @messages = ms.page(params[:page]).per(30)
    elsif params[:view] == "calendar"
      @messages = ms
    else
      @messages = ms.page(params[:page]).per(10)
    end

    respond_to do |format|
      format.html
      format.csv { render :text => current_user.messages.download_csv }
    end
  end

  def show
  end

  def new
    3.times { @message.verses.build(user: current_user) }
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
      format.html { redirect_to messages_url(:view => "list") }
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

end
