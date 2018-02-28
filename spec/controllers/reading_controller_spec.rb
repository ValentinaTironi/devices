require 'rails_helper'

describe ReadingsController do

  let(:reading_class) { Reading }
  let(:device) { create(:device, :name_valid) }

  describe 'POST #create' do


    context 'with valid attributes' do

      let(:reading) { attributes_for(:reading, :value_valid) }

      before do
        post :create, params: { reading: reading, device_id: device.id }
      end

      it 'creates a new reading' do
        expect { post :create, params: { reading: reading, device_id: device.id } }
          .to change(reading_class, :count).by(1)
      end

      it 'return 200 status' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid attributes' do

      let(:invalid_reading) { attributes_for(:reading, :value_invalid) }

      before do
        post :create, params: { reading: invalid_reading, device_id: device.id }
      end

      it 'does not create a new reading' do
        expect { post :create, params: { reading: invalid_reading, device_id: device.id } }
          .to change(reading_class, :count).by(0)
      end

      it 'return 400 status' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
