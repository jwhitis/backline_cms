module UsersHelper

  def role_options_for_select selected_role_name
    roles = Role::VALID_NAMES.map { |name| [formatted_role_name(name), name] }
    options_for_select(roles, selected_role_name)
  end

  def formatted_role_name name
    name.sub(/\Asite_/, "").titleize
  end

  def password_reset_title
    @user.new_account? ? "Set Password" : "New Password"
  end

  def site_titles
    @user.sites.pluck(:title).to_sentence
  end

end