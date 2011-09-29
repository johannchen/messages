class MessagesController < ApplicationController
  load_and_authorize_resource

  def index
    if params[:search]
      @messages = Message.search(params[:search]).page(params[:page]).per(10)
    else
      @messages = Message.order("mdate DESC").page(params[:page]).per(10)
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
end
