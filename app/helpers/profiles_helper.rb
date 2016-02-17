module ProfilesHelper

  def name
    @profile.user.name.capitalize
  end

  def edit_accessible_profile?
    current_user.admin? || current_user.id == @profile.user.id
  end

  def user
    @profile.user
  end


end
