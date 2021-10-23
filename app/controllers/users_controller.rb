class UsersController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, only: [:create]

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.create(user_params)
  end

  def destroy
    @user.destroy
    redirect_to :root
  end

  private

  def user_params
    params.require(:user).permit(:name, :surname)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :surname])
  end
end
