class DevicesController < ApplicationController

  def index
    @devices = Device.all
  end

  def show
    @device = Device.find(params[:id])
  end

  def new
    @device = Device.new
  end

  def edit
    @device = Device.find(params[:id])
  end

  def create
    @device = Device.new(device_params)
    if @device.save
      redirect_to @device
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def update
    @device = Device.find(params[:id])
    if @device.update(device_params)
      redirect_to @device
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  private

  def device_params
    params.require(:device).permit(:name, :mac_address)
  end
end
