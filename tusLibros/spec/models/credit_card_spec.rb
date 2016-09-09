require 'rails_helper'
require_relative '../../spec/credit_card_factory_for_testing'
require_relative '../../app/models/credit_card'

RSpec.configure do |c|
  c.include CreditCardFactoryForTesting
end


describe CreditCard do
  let(:an_user) { User.create(user_name: 'Pppp', password: '0000000') }
  let(:invalid_credit_card) { CreditCard.create(credit_card_owner: an_invalid_credit_card_owner, credit_card_number: a_credit_card_number, expiration_date: an_expiration_date, user_id: an_user.id) }
  let(:valid_credit_card_number_1) { CreditCard.create!(credit_card_owner: a_valid_credit_card_owner, credit_card_number: a_valid_credit_card_number, expiration_date: a_valid_expiration_date, user_id: an_user.id) }
  let(:valid_credit_card_number_2) { CreditCard.create!(credit_card_owner: 'Marco Gatti', credit_card_number: '1234567890123456', expiration_date: a_valid_expiration_date, user_id: an_user.id) }
  context 'When creating a credit card' do
    let(:an_expiration_date) { a_valid_expiration_date }
    let(:a_credit_card_number) { a_valid_credit_card_number }
    let(:an_invalid_credit_card_owner) { 'Esto Es Un Nombre Demasiado Largo Para Una Tarjeta De Credito' }

    context 'and the credit card number is too short' do
      let(:a_credit_card_number) { '431444153' }
      it 'should raise an error of invalid card' do
        expect(invalid_credit_card).not_to be_valid
      end
    end

    context 'and the credit card number has letters' do
      let(:a_credit_card_number) { '471237ASD1444153' }
      it 'should raise an error of invalid card' do
        expect(invalid_credit_card).not_to be_valid
      end
    end


    context 'and the expiration date has already past' do
      let(:an_expiration_date) { Date.new(2000, 12, 1) }
      it 'should raise an error of expired credit card' do
        expect(invalid_credit_card).not_to be_valid
      end
    end

    context 'and the credit card owner is too long' do
      it 'should raise an error credit card owner invalid' do
        expect(invalid_credit_card).to_not be_valid
      end
    end
    context 'and you want to know every user credit card ' do
      it 'should have all the ' do
        valid_credit_card_number_1.save
        expect(an_user.credit_cards).to eq [valid_credit_card_number_1,valid_credit_card_number_2]
      end
    end
  end
end
