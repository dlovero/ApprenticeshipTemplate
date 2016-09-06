require 'rails_helper'

RSpec.describe Cart do

  let(:a_cart) { Cart.create() }
  let(:a_book) { Book.create() }

  context 'When having a new cart' do
    it 'should be empty' do
      expect(a_cart).to be_empty
    end


    it 'should have a zero amount of books' do
      expect(a_cart.amount_of_books).to be 0
    end

    context 'and you add it a book' do
      before do
        a_cart.add(a_book, 1)
      end


      it 'should not be empty' do
        expect(a_cart).not_to be_empty
      end

      it 'should have 1 book' do
        expect(a_cart.amount_of_books).to eq 1
      end

      context 'and you add other book' do
        before do
          a_cart.add(a_book, 1)
        end

        it 'should have 2 books' do
          expect(a_cart.amount_of_books).to eq 2
        end


        it 'should have the same book twice' do
          expect(a_cart.occurrences_of(a_book)).to eq 2
        end

      end

    end

  end
end
