require 'rails_helper'
require_relative '../../spec/credit_card_factory_for_testing'

RSpec.configure do |c|
  c.include CreditCardFactoryForTesting
end

describe Cashier do
  context 'When checking out with a valid credit card' do
    let(:a_client) { User.create(user_name: 'Chichi Peralta', password: '1234567') }
    let(:merchant_processor) { instance_spy(MerchantProcessor) }
    let(:cashier) { Cashier.new(merchant_processor) }
    let(:a_credit_card) { CreditCard.create!(credit_card_owner: a_valid_credit_card_owner, credit_card_number: a_valid_credit_card_number, expiration_date: a_valid_expiration_date, user: a_client) }
    let(:cart_session) { CartSession.for!(a_client) }
    let(:a_book) { Book.create(isbn: '1234227323', price: 14) }
    let(:another_book) { Book.create(isbn: '1231231231', price: 15) }

    context 'and an empty cart' do
      it 'should raise an error the cart cannot be empty' do
        expect { cashier.checkout(cart_session, a_credit_card) }.to raise_error Cashier.error_message_checking_out_an_empty_cart
      end
    end

    context 'and a cart with a book' do
      before do
        cart_session.add(a_book, 1)
        cashier.checkout(cart_session, a_credit_card)
      end

      it 'should bill the credit cart a total amount equal to the price of the book' do
        expect(merchant_processor).to have_received(:charge).with(a_credit_card, 14)
      end
    end

    context 'and a cart with two different books' do
      let(:total_price_of_books) { a_book.price + another_book.price * 2 }
      before do
        cart_session.add(a_book, 1)
        cart_session.add(another_book, 2)
        cashier.checkout(cart_session, a_credit_card)
      end

      it 'should bill the credit card a total amount equal to the price of each book multiplied by the number of that book' do
        expect(merchant_processor).to have_received(:charge).with(a_credit_card, total_price_of_books)
      end

      it 'should appear the sale on the sale book' do
        sale = Sale.last
        expect(sale.items.first.book.isbn).to eq '1234227323'
        expect(sale.total_price).to eq total_price_of_books
      end

      it 'the client should have one sale registered' do
        sales = Sale.select { |a_sale| a_sale.user_id == a_client.id }
        expect(sales.size).to eq 1
      end

      it 'the sale should be the last of this client' do
        sale = Sale.find_by(user_id: a_client.id)
        expect(sale.items.first.book_id).to eq(a_book.id)
        expect(sale.items.second.book_id).to eq(another_book.id)
        expect(sale.user_id).to eq(a_client.id)
        expect(sale.total_price).to eq total_price_of_books
      end
    end
  end
end


