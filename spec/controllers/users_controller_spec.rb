require 'rails_helper'

describe UsersController, 'Users Controller' do

  let(:user_class) { User }

  describe 'GET #index' do

    let(:users) { [create(:user, :name_valid)] }

    before do
      get :index
    end

    it { expect(response).to have_http_status(:success) }

    it 'get all users' do
      expect(assigns(:users)).to match_array(users)
    end

    it 'renders the :index view' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do

    context 'valid id' do

      subject { create(:user, :name_valid) }

      before do
        get :show, params: { id: subject.id }
      end

      it { expect(response).to have_http_status(:success) }

      it 'assigns the requested user to @user' do
        expect(assigns(:user)).to eq(subject)
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

      it 'renders not_found template' do
        expect(response).to render_template('not_found')
      end

    end
  end

  describe 'GET #new' do

    before do
      get :new
    end

    it { expect(response).to have_http_status(:success) }

    it 'assigns a new User to @user' do
      expect(assigns(:user)).to be_a(user_class)
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do

    context 'valid id' do

      subject { create(:user, :name_valid) }

      before do
        get :edit, params: { id: subject.id }
      end

      it { expect(response).to have_http_status(:success) }

      it 'assigns the requested user to @user' do
        expect(assigns(:user)).to eq(subject)
      end

      it 'renders the edit template' do
        expect(response).to render_template('edit')
      end
    end

    context 'invalid id' do

      let(:id) { 'invalid_id' }

      before do
        get :edit, params: { id: id }
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

      let(:user) { attributes_for(:user, :name_valid) }

      before do
        post :create, params: { user: user }
      end

      it 'creates a new user' do
        expect { post :create, params: { user: user } }
          .to change(user_class, :count).by(1)
      end

      it 'redirects to the new device' do
        expect(:user).to redirect_to(user_class.last)
      end

      it 'return 302 status' do
        expect(response).to have_http_status(:found)
      end
    end

    context 'with invalid attributes' do

      let(:invalid_user) { attributes_for(:user, :name_invalid) }

      before do
        post :create, params: { user: invalid_user }
      end

      it 'does not create a new user' do
        expect { post :create, params: { user: invalid_user } }
          .to change(user_class, :count).by(0)
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

    subject { create(:user, :name_valid) }

    context 'valid attributes' do

      let(:attributes) { { first_name: 'new name' } }

      before do
        patch :update, params: {
          id: subject.id,
          user: attributes,
         }
      end

      it 'update data success' do
        subject.reload
        expect(subject.first_name).to eq('new name')
      end

      it 'return 302 status (found)' do
        expect(response).to have_http_status(:found)
      end

      it 'assigns the requested user to @user' do
        expect(assigns(:user)).to eq(subject)
      end

      it 'redirects to the user' do
        expect(:user).to redirect_to(subject)
      end
    end

    context 'invalid attributes' do

      let(:attributes) { { first_name: nil } }

      before do
        patch :update, params: {
          id: subject.id,
          user: attributes,
         }
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

    let!(:user) { create(:user, :name_valid) }

    let(:delete_user) { delete :destroy, params: { id: user.id } }

    it 'delete user success' do
      expect { delete_user }.to change(user_class, :count).by(-1)
    end

    it 'redirects to user#index' do
      delete_user
      expect(response).to redirect_to users_path
    end

    it 'return 302 status (found)' do
      delete_user
      expect(response).to have_http_status(:found)
    end
  end
end
