class DevicesController < ApplicationController
  before_action :get_user, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :find_device, only: [:show, :edit, :update, :destroy]


  def index
    @devices = Device.all
  end

  def show; end

  def new
    @device = Device.new
  end

  def edit; end

  def create
    @device = @user.devices.create(device_params)
    if @device.save
      redirect_to user_device_url(@user.id, @device.id)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def update
    if @device.update(device_params)
      redirect_to user_device_url(@user.id, @device.id)
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @device.destroy!
    redirect_to user_devices_url(@user.id)
  end

  private

  def device_params
    params.require(:device).permit(:name, :mac_address, :user_id)
  end

  def find_device
    @device = Device.find(params[:id])
  end

  def get_user
    @user = User.find(params[:user_id])
  end
end
