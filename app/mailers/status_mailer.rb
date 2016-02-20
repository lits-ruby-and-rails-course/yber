class StatusMailer < ApplicationMailer
  default from: "yber@example.com"

  def accepted_status_email(rider)
    @rider = rider
    mail(to: @rider.email, subject: 'Yber Email: Accept order.')
  end

  def completed_status_email(order)
    @order = order
    @user = order.rider
    mail(to: @user.email, subject: 'Yber Email: Complete order.')
    @user = order.driver
    mail(to: @user.email, subject: 'Yber Email: Complete order.')
  end
end
