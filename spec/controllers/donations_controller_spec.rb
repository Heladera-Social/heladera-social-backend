require 'rails_helper'

describe DonationsController do
  let!(:user) { create(:user) }
  let!(:storage_unit) { create(:storage_unit) }
  let!(:meat) { create(:product_type, name: 'Meat') }
  let!(:beans) { create(:product_type, name: 'Canned Beans') }
  let(:donation_params) do
    {
      storage_unit_id: storage_unit.id,
      donation_products_attributes: [
        { product_type_id: meat, quantity: 1, expiration_date: Time.zone.today },
        { product_type_id: meat, quantity: 1, expiration_date: Time.zone.tomorrow },
        { product_type_id: beans, quantity: 2, label: 'Beans' }
      ]
    }
  end

  before(:each) { sign_in user }
  
  describe '#create' do
    it 'creates a donation' do
      post :create, donation: donation_params
      expect(Donation.count).to eq 1
    end

    it 'creates the 3 storage unit inventory products' do
      post :create, donation: donation_params
      expect(Product.count).to eq 3
    end

    it 'creates the 3 donation product logs' do
      post :create, donation: donation_params
      expect(DonationProduct.count).to eq 3
    end

    it 'labels products correctly' do
      post :create, donation: donation_params
      expect(Product.where(label: 'Beans').count).to eq 1
    end


    it 'sets the 3 storage unit inventory products' do
      post :create, donation: donation_params
      expect(storage_unit.products.count).to eq 3
    end
  end
end
