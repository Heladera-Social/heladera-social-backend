require 'rails_helper'

describe ExtractionsController do
  let!(:user) { create(:user) }
  let!(:storage_unit) { create(:storage_unit) }
  let!(:meat) { create(:product_type, name: 'Meat') }
  let!(:beans) { create(:product_type, name: 'Canned Beans') }
  let!(:meat1) do
    create(:donation_product, product_type: meat, quantity: 3, expiration_date: Time.zone.today)
  end
  let!(:meat2) do
    create(:donation_product, product_type: meat, quantity: 2, expiration_date: Time.zone.tomorrow)
  end
  let!(:donation) do
    create(:donation, user: user, storage_unit: storage_unit, donation_products: [meat1, meat2])
  end
  let!(:start_inventory) { storage_unit.products.order('expiration_date ASC') }

  let(:extraction_params) do
    { storage_unit_id: storage_unit.id,
      extraction_products_attributes: [
        { product_id: start_inventory.first.id, quantity: 3 },
        { product_id: start_inventory.second.id, quantity: 1 }
      ]
    }
  end

  before(:each) { sign_in user }
  
  describe '#create' do
    it 'creates an extraction' do
      post :create, extraction: extraction_params
      expect(Extraction.count).to eq(1)
    end

    it 'returns the extraction product with the received amount' do
      post :create, extraction: extraction_params
      expect(ExtractionProduct.count).to eq(2)
      expect(ExtractionProduct.first.quantity).to eq(3)
      expect(ExtractionProduct.second.quantity).to eq(1)
    end

    it 'extracts the products from the storage unit correctly' do
      post :create, extraction: extraction_params
      inventory = storage_unit.products.order('expiration_date ASC')
      expect(inventory.first.quantity).to eq 0
      expect(inventory.second.quantity).to eq 1
    end

    it 'sets an halfway extracted product to opened' do
      post :create, extraction: extraction_params
      inventory = storage_unit.products.order('expiration_date ASC')
      expect(inventory.second.opened).to eq true
      expect(inventory.second.open_date).to eq Time.zone.today
    end
  end
end
