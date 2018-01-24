class DevicesController < ApplicationController

  def show
    @device = Device.find(params[:id])
  end

  def new
    @device = Device.new
  end

  def edit
    @devices = Device.find(params[:id])
  end

  def create
    @device = Device.new(device_params)

    @device.save
    redirect_to @device
  end

  def update
    @device = Device.find(params[:id])

    if @device.update(device_params)
      redirect_to @device
    else
      render 'edit'
    end
  end

  private

  def device_params
    params.require(:device).permit(:name, :mac_address)
  end
end
