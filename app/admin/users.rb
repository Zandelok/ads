ActiveAdmin.register User do
  permit_params :name, :surname, :email, :description

  action_item :view, only: %i[show make_admin make_user] do
    case user.role.name
    when 'user'
      link_to 'Make Admin', make_user_an_admin_path
    when 'admin'
      link_to 'Make User', make_admin_an_user_path
    end
  end
end
