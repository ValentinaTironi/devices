require 'rails_helper'

describe DevicesController, 'Devices Controller' do

  let(:device_class) { Device }

  describe 'GET #index' do

    let(:devices) { [create(:device, :name_valid)] }

    before do
      get :index
    end

    it { expect(response).to have_http_status(:success) }

    it 'get all devices' do
      expect(assigns(:devices)).to match_array(devices)
    end

    it 'renders the :index view' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do

    context 'valid id' do

      subject { create(:device, :name_valid) }

      before do
        get :show, params: { id: subject.id }
      end

      it { expect(response).to have_http_status(:success) }

      it 'assigns the requested device to @device' do
        expect(assigns(:device)).to eq(subject)
      end

      it 'renders the show template' do
        expect(response).to render_template('show')
      end
    end

    context 'invalid id' do

      let(:id) { 'invalid_id' }

      before do
        get :show, params: { id: id }
      end

      it 'return a error' do
        expect(response).to have_http_status(:not_found)
      end

      it 'renders the show template' do
        expect(response).to render_template('not_found')
      end

    end
  end

  describe 'GET #new' do

    before do
      get :new
    end

    it { expect(response).to have_http_status(:success) }

    it 'assigns a new Device to @device' do
      expect(assigns(:device)).to be_a(device_class)
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do

    context 'with valid attributes' do

      let(:device) { attributes_for(:device, :name_valid) }

      before do
        post :create, params: { device: device }
      end

      it 'creates a new device' do
        expect { post :create, params: { device: device } }
          .to change(Device, :count).by(1)
      end

      it 'redirects to the new device' do
        expect(:device).to redirect_to(Device.last)
      end

      it 'return 302 status' do
         expect(response).to have_http_status(:found)
      end

    end

    context 'with invalid attributes' do

      let(:invalid_device) { attributes_for(:device, :name_invalid) }

      before do
        post :create, params: { device: invalid_device }
      end

      it 'does not create a new device' do
        expect { post :create, params: { device: invalid_device } }
          .to change(Device, :count).by(0)
      end

      it 'renders to new template' do
        expect(response).to render_template('new')
      end

      it 'return 422 status' do
         expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

end
