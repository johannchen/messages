class FeedbacksController < ApplicationController
  def new
  end

  # send feedback mail
  def create
    Feedback.feedback_mail(current_user).deliver
  end
end
