require 'rails_helper'
require_relative 'credit_card_factory_for_testing'
require_relative '../../app/models/credit_card'

RSpec.configure do |c|
  c.include CreditCardFactoryForTesting
end


describe CreditCard do
  subject { CreditCard.create(credit_card_owner: a_credit_card_owner, credit_card_number: a_credit_card_number, expiration_date: an_expiration_date) }
  context 'When creating a credit card' do
    let(:an_expiration_date) { a_valid_expiration_date }
    let(:a_credit_card_number) { a_valid_credit_card_number }
    let(:a_credit_card_owner) { a_valid_credit_card_owner }

    context 'and the credit card number is too short' do
      let(:a_credit_card_number) { '431444153' }
      it 'should raise an error of invalid card' do
        expect(subject).not_to be_valid
      end
    end

    context 'and the credit card number has letters' do
      let(:a_credit_card_number) { '471237ASD1444153' }
      it 'should raise an error of invalid card' do
        expect(subject).not_to be_valid
      end
    end


    context 'and the expiration date has already past' do
      let(:an_expiration_date) { Date.new(2000, 12, 1) }
      it 'should raise an error of expired credit card' do
        expect(subject).not_to be_valid
      end
    end

    context 'and the credit card owner is too long' do
      let(:a_credit_card_owner) { 'Esto Es Un Nombre Demasiado Largo Para Una Tarjeta De Credito' }
      it 'should raise an error credit card owner invalid' do
        expect(subject).not_to be_valid
      end
    end
  end
end

