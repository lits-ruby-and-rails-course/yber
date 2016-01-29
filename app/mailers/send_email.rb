class SendEmail < ApplicationMailer
  def send_help_email(help)
    @help = help
    mail to: "mykhaylo.yusko@gmail.com", subject: "Hello"
  end
end
