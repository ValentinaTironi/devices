class Api::ReadingsController < Api::ApplicationController

  before_action :device

  def create
    @reading = device.readings.create(reading_params)
    if @reading.save
      render json: @reading
    else
      render json: @reading.errors.full_messages, status: :bad_request
    end
  end

  private

  def reading_params
    params.require(:reading).permit(:value, :date)
  end

  def user
    data = request.env['jwt.payload']
    User.find_by_email(data['data']['email'])
  end

  def device
    user.devices.find(params[:device_id])
  end
end
