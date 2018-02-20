require 'rails_helper'

describe DevicesController, 'Devices Controller' do

  let(:device_class) { Device }
  let(:user) { create(:user) }


  describe 'GET #index' do

    let(:devices) { [create(:device, :name_valid)] }

    before do
      get :index, params: { user_id: user.id }
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
        get :show, params: { id: subject.id, user_id: user.id }
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
        get :show, params: { id: id, user_id: user.id }
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
      get :new, params: { user_id: user.id }
    end

    it { expect(response).to have_http_status(:success) }

    it 'assigns a new Device to @device' do
      expect(assigns(:device)).to be_a(device_class)
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do

    context 'valid id' do

      subject { create(:device, :name_valid) }

      before do
        get :edit, params: { id: subject.id, user_id: user.id }
      end

      it { expect(response).to have_http_status(:success) }

      it 'assigns the requested device to @device' do
        expect(assigns(:device)).to eq(subject)
      end

      it 'renders the edit template' do
        expect(response).to render_template('edit')
      end
    end

    context 'invalid id' do

      let(:id) { 'invalid_id' }

      before do
        get :edit, params: { id: id, user_id: user.id }
      end

      it 'return a error' do
        expect(response).to have_http_status(:not_found)
      end

      it 'renders the show template' do
        expect(response).to render_template('not_found')
      end

    end
  end

  describe 'POST #create' do

    context 'with valid attributes' do

      let(:device) { attributes_for(:device, :name_valid) }

      before do
        post :create, params: { device: device, user_id: user.id }
      end

      it 'creates a new device' do
        expect { post :create, params: { device: device, user_id: user.id } }
          .to change(device_class, :count).by(1)
      end

      it 'redirects to the new device' do
        expect(:device).to redirect_to(user_device_url(user.id, device_class.last))
      end

      it 'return 302 status' do
        expect(response).to have_http_status(:found)
      end
    end

    context 'with invalid attributes' do

      let(:invalid_device) { attributes_for(:device, :name_invalid) }

      before do
        post :create, params: { device: invalid_device, user_id: user.id }
      end

      it 'does not create a new device' do
        expect { post :create, params: { device: invalid_device, user_id: user.id } }
          .to change(device_class, :count).by(0)
      end

      it 'renders to new template' do
        expect(response).to render_template(:new)
      end

      it 'return 422 status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do

    subject { create(:device, :name_valid) }

    context 'valid attributes' do

      let(:attributes) { { name: 'new name', mac_address: 111 } }

      before do
        patch :update, params: { id: subject.id, device: attributes }
      end

      it 'update data success' do
        subject.reload
        expect(subject.name).to eq('new name')
      end

      it 'return 302 status (found)' do
        expect(response).to have_http_status(:found)
      end

      it 'assigns the requested device to @device' do
        expect(assigns(:device)).to eq(subject)
      end

      it 'redirects to the device' do
        expect(:device).to redirect_to(subject)
      end
    end

    context 'invalid attributes' do

      let(:attributes) { { name: 'new name', mac_address: nil } }

      before do
        patch :update, params: { id: subject.id, device: attributes }
      end

      it 'renders to edit template' do
        expect(response).to render_template(:edit)
      end

      it 'return 422 status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE destroy' do

    let!(:device) { create(:device, :name_valid) }

    let(:delete_device) { delete :destroy, params: { id: device.id } }

    it 'delete device success' do
      expect { delete_device }.to change(device_class, :count).by(-1)
    end

    it 'redirects to devices#index' do
      delete_device
      expect(response).to redirect_to devices_path
    end

    it 'return 302 status (found)' do
      delete_device
      expect(response).to have_http_status(:found)
    end
  end
end
