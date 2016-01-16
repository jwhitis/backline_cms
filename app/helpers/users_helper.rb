module UsersHelper

  def role_options_for_select selected_role_name
    roles = Role::NAMES.map { |name| [formatted_role_name(name), name] }
    options_for_select(roles, selected_role_name)
  end

  def formatted_role_name name
    name.sub(/\Asite_/, "").titleize
  end

end