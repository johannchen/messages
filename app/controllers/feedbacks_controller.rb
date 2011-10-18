class FeedbacksController < ApplicationController
  skip_authorization_check

  def new
  end

  # send feedback mail
  def create
    msg = params[:feedback]
    FeedbackMailer.feedback_mail(current_user, msg).deliver if msg.present?
    redirect_to feedback_path, :notice => "Thank you for your feedback!"
  end
end
