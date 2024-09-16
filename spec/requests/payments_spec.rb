# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Payments', type: :request do
  let(:customer) { create(:customer) }

  describe 'GET /customer/:customer_id/payments/new' do
    let(:route) { "/customers/#{customer.id}/payments/new" }

    context 'customer is approved' do
      it 'renders the new payment form' do
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

  describe 'POST /customer/:customer_id/payments' do
    let(:route) { "/customers/#{customer.id}/payments" }
    let(:payment_params) do
      {
        phone: '+27724576543',
        telco: 'MTN'
      }
    end

    context 'valid phone and telco' do
      it 'creates a new payment and redirects' do
        expect do
          post route, params: { payment: payment_params }
        end.to change { Payment.count }.by(1)
        payment = Payment.last
        expect(payment.amount).to eq(customer.registration_phone_price)
        expect(response).to redirect_to(pending_customer_payment_path(customer, payment))
      end
    end

    context 'invalid phone and telco' do
      let(:payment_params) do
        {
          telco: 'MTN'
        }
      end

      it 'does not create payment' do
        expect do
          post route, params: { payment: payment_params }
        end.to_not(change { Payment.count })
      end
    end
  end

  describe 'PUT /customer/:customer_id/payments/:id' do
    let(:payment) { create(:payment) }
    let(:route) { "/customers/#{customer.id}/payments/#{payment.id}" }
    context 'valid status' do
      let(:payment_params) do
        {
          status: 'paid'
        }
      end

      it 'updates payment' do
        expect(payment).to be_pending
        put route, params: { payment: payment_params }
        expect(payment.reload).to be_paid
      end
    end

    context 'invalid status' do
      let(:payment_params) do
        {
          status: 'foo'
        }
      end

      it 'updates payment' do
        expect(payment).to be_pending
        put route, params: { payment: payment_params }
        expect(payment.reload).to be_pending
      end
    end
  end

  describe 'GET /customer/:customer_id/payments/:id/pending' do
    let(:payment) { create(:payment) }
    let(:route) { "/customers/#{customer.id}/payments/#{payment.id}/pending" }
    it 'shows pending' do
      get route
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /customer/:customer_id/payments/show' do
    let(:payment) { create(:payment) }
    let(:route) { "/customers/#{customer.id}/payments/#{payment.id}" }
    it 'shows payment' do
      get route
      expect(response).to have_http_status(200)
    end
  end
end
