class UsersController < Devise::RegistrationsController
  load_and_authorize_resource

  before_action :find_user, only: %i[show make_admin make_user destroy change_role]

  def show; end

  def destroy
    @user.destroy
    redirect_to :root
  end

  def make_admin
    @user.assign_admin_role
    redirect_to admin_users_path
  end

  def make_user
    @user.assign_user_role
    redirect_to admin_users_path
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
