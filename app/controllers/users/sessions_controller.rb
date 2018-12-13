# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  respond_to :json

  # # disable the CSRF token
  # protect_from_forgery with: :null_session

  # # disable cookies (no set-cookies header in response)
  # before_action :destroy_session

  # # disable the CSRF token
  # skip_before_action :verify_authenticity_token, :only => :create


  # def destroy_session
  #     request.session_options[:skip] = true
  # end
  
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super
    session[:current_user_id] = @user.id
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  # end
  

  private

  def respond_with(resource, _opts = {})
    render json: resource
  end

  def respond_to_on_destroy
    head :no_content
  end
end
