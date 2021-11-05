ActiveAdmin.setup do |config|
  config.site_title = "Ads"
  config.authorization_adapter = ActiveAdmin::CanCanAdapter
  config.current_user_method = :current_user
  config.logout_link_path = :destroy_user_session_path
  config.batch_actions = true
  config.filter_attributes = [:encrypted_password, :password, :password_confirmation]
  config.localize_format = :long
  config.default_per_page = 30
end
