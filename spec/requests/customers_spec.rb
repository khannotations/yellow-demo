# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Customers', type: :request do
  describe 'POST /customer' do
    let(:customer_params) do
      {
        first_name: 'John',
        last_name: 'Doe',
        id_number: '123456789',
        phone: '+27721600241',
        birthday: 20.years.ago,
        registration_phone_price_cents: 100,
        registration_phone_price_currency: 'USD'
      }
    end

    context 'valid customer' do
      it 'creates a new customer and redirects' do
        expect do
          post '/customers', params: { customer: customer_params }
        end.to change { Customer.count }.by(1)
        customer = Customer.last
        expect(customer.first_name).to eq('John')
        expect(customer.registration_phone_price).to eq(Money.new(100, 'USD'))
        expect(response).to redirect_to(new_customer_phone_path(Customer.last))
      end
    end

    context 'invalid customer' do
      context 'birthday is less than 18 years ago' do
        before do
          customer_params[:birthday] = 17.years.ago
        end

        it 'does not create a new customer' do
          expect do
            post '/customers', params: { customer: customer_params }
          end.not_to(change { Customer.count })
          expect(response.body).to include('Birthday must be')
        end
      end
    end
  end
end
