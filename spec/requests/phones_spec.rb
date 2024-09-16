# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Phones', type: :request do
  describe 'GET /customer/:customer_id/phones/new' do
    let(:customer) { create(:customer) }
    let(:route) { "/customers/#{customer.id}/phones/new" }

    context 'customer is approved' do
      it 'renders the new phone form' do
        get route
        expect(response).to have_http_status(200)
      end
    end

    context 'customer is not approved' do
      before { customer.update(approved_at: nil) }
      it 'redirects to the root path' do
        get route
        expect(response).to redirect_to(new_customer_path)
      end
    end
  end

  describe 'POST /customer/:customer_id/phones' do
    let(:customer) { create(:customer) }
    let(:route) { "/customers/#{customer.id}/phones" }
    let(:phone_params) do
      {
        imei: '307543415456705'
      }
    end

    context 'valid phone' do
      it 'creates a new phone and redirects' do
        expect do
          post route, params: { phone: phone_params }
        end.to change { Phone.count }.by(1)
        phone = Phone.last
        expect(phone.imei).to eq(phone_params[:imei])
        expect(response).to redirect_to(new_customer_payment_path(customer))
      end
    end

    context 'invalid phone' do
      context 'IMEI is too short' do
        before do
          phone_params[:imei] = 'test'
        end

        it 'does not create a new phone' do
          expect do
            post route, params: { customer: phone_params }
          end.not_to(change { Phone.count })
        end
      end
    end
  end
end
