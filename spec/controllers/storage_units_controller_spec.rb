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

  describe '#product_types' do
    let!(:meat) { create(:product_type, name: 'Meat') }
    let!(:beans) { create(:product_type, name: 'Canned Beans') }
    let!(:bananas) { create(:product_type, name: 'Bananas') }
    let!(:meat1) do
      create(:donation_product, product_type: meat, quantity: 3, expiration_date: Time.zone.today)
    end
    let!(:beans1) do
      create(
        :donation_product,
        product_type: meat,
        quantity: 2,
        expiration_date: Time.zone.yesterday
      )
    end
    let!(:donation) do
      create(:donation, user: user, storage_unit: storage_unit, donation_products: [meat1, beans1])
    end
    context 'User is signed in' do
      before(:each) { sign_in user }

      it 'shows an available product type' do
        get :product_types, id: storage_unit.id
        expect(product_type_ids).to include meat.id
      end

      it 'does not show a product type that is not in the storage unit' do
        get :product_types, id: storage_unit.id
        expect(product_type_ids).not_to include bananas.id
      end

      it 'does not show a product type where all the products are expired' do
        get :product_types, id: storage_unit.id
        expect(product_type_ids).not_to include beans.id
      end
    end

    def product_type_ids
      JSON.parse(response.body).map { |type| type['id'] }
    end
  end
end
