class StatusMailer < ApplicationMailer
  default from: "yber@example.com"
  # layout "status_mailer"

  def completed_status_email(user)
    @user = user
    mail(to: @user.email, subject: 'Yber Email',
         template_path: 'status_mailer',
         template_name: 'completed_status_email')
  end
end
