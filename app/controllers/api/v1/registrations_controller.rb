class Api::V1::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_params_exit, only: :create
  skip_before_action :verify_authenticity_token

  def create
    #code
    user = User.new user_params
    if user.save
      json_response "Signed Up successfully", true, {user: user}, :ok
    else
      json_response "Something wrong", false, {}, :unprocessable_entity
    end
  end

  private
  def user_params
    #code
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def ensure_params_exit
    #code
    return if params[:user].present?
      json_response "Missing Params", false, {}, :bad_request
    
  end
end