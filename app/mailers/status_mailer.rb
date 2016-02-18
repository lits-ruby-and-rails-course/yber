class StatusMailer < ApplicationMailer
  default from: "yber@example.com"

  def accepted_status_email(rider)
    @rider = rider
    mail(to: @rider.email, subject: 'Yber Email: Accept order.')
  end

  def completed_status_email(rider, driver, order)
    @order = order
    @user = rider
    mail(to: @user.email, subject: 'Yber Email: Complete order.')
    @user = driver
    mail(to: @user.email, subject: 'Yber Email: Complete order.')
  end
end
