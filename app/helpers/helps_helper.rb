module HelpsHelper
  def placeholder_email
    if user_signed_in?
      current_user.email
    else
      "your email"
    end
  end
end
