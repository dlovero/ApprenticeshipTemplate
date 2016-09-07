require 'rails_helper'
require_relative 'credit_card_factory_for_testing'

RSpec.configure do |c|
  c.include CreditCardFactoryForTesting
end

describe Cashier do
  context 'When checking out with a valid credit card' do
    #let(:sales_book) { a_sales_book }
    #let(:merchant_processor_stub) { MerchantProcessorStub.new }
    let(:cashier) { Cashier.new() }
    let(:a_credit_card) { a_valid_credit_card }
    let(:cart) { Cart.create() }

    context 'and an empty cart' do
      it 'should raise an error the cart cannot be empty' do
        expect { cashier.checkout(cart, a_credit_card) }.to raise_error Cashier.error_message_checking_out_an_empty_cart
      end
    end
=begin
    context 'and a cart with a book' do
      before do
        cart.add(a_book, 1)
        cashier.checkout(cart, a_credit_card)
      end

      it 'should bill the credit cart a total amount equal to the price of the book' do
        expect(merchant_processor_stub.has_billed_card_with?(a_credit_card, price_for(a_book))).to be true
      end
    end

    context 'and a cart with two different books' do
      let(:total_price_of_books) { price_for(a_book) + price_for(another_book) * 2 }
      before do
        cart.add(a_book,1)
        cart.add(another_book,2)
        cashier.checkout(cart, a_credit_card)
      end

      it 'should bill the credit card a total amount equal to the price of each book multiplied by the number of that book' do
        expect(merchant_processor_stub.has_billed_card_with?(a_credit_card, total_price_of_books)).to be true
      end

      it 'should appear the sale on the sale book' do
        sale = sales_book.last
        expect(sale.items).to eq({ a_book => 1, another_book => 2 })
        expect(sale.total_price).to eq total_price_of_books
      end

      it 'the client should have one sale registered' do
        sales = sales_book.sale_done_by(a_client)
        expect(sales.size).to eq 1
      end

      it 'the sale should be the last of this client' do
        sales = sales_book.sale_done_by(a_client)
        expect(sales.first).to eq({ a_book => 1, another_book => 2 })
        expect(sale.total_price).to eq total_price_of_books
      end
=end
  end
end
