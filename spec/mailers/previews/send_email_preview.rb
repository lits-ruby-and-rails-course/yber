# Preview all emails at http://localhost:3000/rails/mailers/send_email
class SendEmailPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/send_email/send_help_email
  def send_help_email
    SendEmail.send_help_email
  end

end
