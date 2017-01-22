require 'rails_helper'

describe DonationsController do
  let!(:user) { create(:user) }
  let!(:storage_unit) { create(:storage_unit) }
  let!(:meat) { create(:product_type, name: 'Meat') }
  let!(:beans) { create(:product_type, name: 'Canned Beans') }

  before(:each) { sign_in user }

  describe '#create' do
    context 'when the donation delivery is confirmed' do
      let(:donation_params) do
        {
          storage_unit_id: storage_unit.id,
          donation_products_attributes: [
            { product_type_id: meat, quantity: 1, expiration_date: Time.zone.today },
            { product_type_id: meat, quantity: 1, expiration_date: Time.zone.tomorrow },
            { product_type_id: beans, quantity: 2, label: 'Beans' }
          ],
          delivered: true
        }
      end

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
    context 'when the donation delivery is not confirmed' do
      let(:unconfirmed_donation_params) do
        {
          storage_unit_id: storage_unit.id,
          donation_products_attributes: [
            { product_type_id: meat, quantity: 1, expiration_date: Time.zone.today },
            { product_type_id: meat, quantity: 1, expiration_date: Time.zone.tomorrow },
            { product_type_id: beans, quantity: 2, label: 'Beans' }
          ],
          delivered: false
        }
      end

      it 'creates a donation' do
        post :create, donation: unconfirmed_donation_params
        expect(Donation.count).to eq 1
      end

      it 'creates the 3 storage unit inventory products' do
        post :create, donation: unconfirmed_donation_params
        expect(Product.count).to eq 0
      end

      it 'creates the 3 donation product logs' do
        post :create, donation: unconfirmed_donation_params
        expect(DonationProduct.count).to eq 3
      end

      it 'does not add products to the storage unit' do
        post :create, donation: unconfirmed_donation_params
        expect(storage_unit.products.count).to eq 0
      end
    end
  end

  describe '#confirm_delivery' do
    let!(:meat1) do
      create(:donation_product, product_type: meat, quantity: 3, expiration_date: Time.zone.tomorrow)
    end
    let!(:beans1) do
      create(
        :donation_product,
        product_type: meat,
        quantity: 2,
        expiration_date: Time.zone.tomorrow
      )
    end
    let!(:donation) do
      create(
        :donation, delivered: false,
        user: user, storage_unit: storage_unit, donation_products: [meat1, beans1]
      )
    end

    it 'sets the donation status to delivered' do
      post :confirm_delivery, id: donation.id
      expect(Donation.first.delivered).to be true
    end

    it 'creates the 2 storage unit inventory products' do
      post :confirm_delivery, id: donation.id
      expect(Product.count).to eq 2
    end

    it 'adds the product to the storage unit' do
      post :confirm_delivery, id: donation.id
      expect(storage_unit.products.count).to eq 2
    end
  end
end
