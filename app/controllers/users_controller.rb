class UsersController < Devise::RegistrationsController
  load_and_authorize_resource

  before_action :configure_permitted_parameters, only: [:create]
  before_action :find_user, only: %i[show destroy change_role]

  def show; end

  def create
    @user = User.create(user_params)
  end

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

  def user_params
    params.require(:user).permit(:name, :surname)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :surname])
  end
end
