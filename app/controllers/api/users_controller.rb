class Api::UsersController < Api::ApplicationController

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
    { data: { email: current_user.email } }
  end
end
