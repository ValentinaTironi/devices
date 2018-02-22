class Api::LoginController < Api::ApplicationController

  require 'jwt'

  def encode(payload)
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def decode(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base)
  end

  def data
    find_user
    data = { data: {email: @user.email } }
  end

  def show
    render json: { access_token: encode(data) }
  end

  private

  def find_user
    @user = User.find_by_email!(params[:email])
  end
end
