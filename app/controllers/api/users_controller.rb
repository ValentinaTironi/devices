class Api::UsersController < Api::ApplicationController
  before_action :find_user

  def login
    render json: { access_token: encode(user_payload) }
  end

  private

  def encode(payload)
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def decode(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base)
  end

  def user_payload
    { data: { email: @user.email } }
  end

  def find_user
    @user = User.find_by_email!(params[:email])
  end
end
