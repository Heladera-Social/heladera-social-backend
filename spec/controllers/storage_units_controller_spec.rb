require 'rails_helper'

describe StorageUnitsController do
  let!(:user) { create(:user) }
  let!(:storage_unit) { create(:storage_unit) }

  describe '#index' do
    it 'returns a 200 status code' do
      get :index
      expect(response).to have_http_status 200
    end

    it 'returns all the storage units if not filtered' do
      get :index
      expect(assigns(:storage_units)).to eq StorageUnit.all
    end
  end

  describe '#favorite' do
    context 'User is signed in' do
      before(:each) { sign_in user }
      
      it 'adds the storage unit as a favorite' do
        post :favorite, id: storage_unit.id
        expect(user.reload.favorite_storage_units).to include storage_unit
      end
    end
  end

  describe '#unfavorite' do
    context 'User is signed in' do
      before(:each) { sign_in user }
      
      it 'removes the storage unit as a favorite' do
        user.update_attributes!(favorite_storage_units: [storage_unit])
        expect(user.reload.favorite_storage_units).to include storage_unit
        delete :unfavorite, id: storage_unit.id
        expect(user.reload.favorite_storage_units).not_to include storage_unit
      end
    end
  end
end