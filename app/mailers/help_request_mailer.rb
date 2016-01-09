class HelpRequestMailer < ApplicationMailer
  def send_email(help)
    @help = help
    mail to: User.where(role: User.roles[:admin]).first.email , subject: "Hello"
  end
end
