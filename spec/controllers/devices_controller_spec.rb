require 'rails_helper'

describe DevicesController, 'Devices Controller' do

  describe 'GET #show' do

    subject { create(:device) }

    it 'assigns the requested device to @device' do
      get :show, params: { id: subject.id }
      expect(assigns(:device)).to eq(subject)
    end

    it 'renders the show template' do
      get :show, params: { id: subject.id }
      expect(response).to render_template('show')
    end
  end

  describe 'GET #new' do

    let(:device_class) { Device }

    it 'assigns a new Device to @device' do
      get :new
      expect(assigns(:device)).to be_a(device_class)
    end

    it 'renders the new template' do
      get :new
      response.should render_template('new')
    end
  end

  describe 'POST #create' do

    context 'with valid attributes' do

      let(:device) { attributes_for(:device) }

      it 'creates a new device' do
        expect { post :create, params: { device: device } }
          .to change(Device, :count).by(1)
      end

      it 'redirects to the new device' do
        post :create, params: { device: device }
        expect(:device).to redirect_to(Device.last)
      end
    end

    context 'with invalid attributes' do

      let(:invalid_device) { attributes_for(:invalid_device) }

      it 'does not create a new device' do
        expect { post :create, params: { device: invalid_device } }
          .to change(Device, :count).by(0)
      end

      it 'renders to new template' do
        post :create, params: { device: invalid_device }
        expect(response).to render_template('new')
      end
    end
  end
end
