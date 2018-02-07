class DevicesController < ApplicationController
  before_action :find_device, only: [:show, :edit, :update]

  def index
    @devices = Device.all
  end

  def show; end

  def new
    @device = Device.new
  end

  def edit; end

  def create
    @device = Device.new(device_params)
    if @device.save
      redirect_to @device
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def update
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

  def find_device
    @device = Device.find(params[:id])
  end
end
