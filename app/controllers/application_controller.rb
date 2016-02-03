class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_admin_user!
    authenticate_user!
    redirect_to root_path unless current_user.admin?
  end

  def help_request
    @help = Help.new(help_params)
    if @help.save
      HelpRequestMailer.send_email(@help).deliver
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def help_params
    params.require(:help).permit(:name, :email, :messages)
  end
end
