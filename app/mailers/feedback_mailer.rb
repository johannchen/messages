class FeedbackMailer < ActionMailer::Base
  default to: "johannchen@gmail.com"

  def feedback_mail(user, msg)
    @msg = msg
    @user = user
    mail(:from => "#{user.name} <#{user.email}>", :subject => "Feedback")
  end
end
