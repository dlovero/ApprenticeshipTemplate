require 'rails_helper'

RSpec.describe CartSession, type: :model do
  let!(:session) { CartSession.for!(User.create!(user_name:'PEPEPE', password:'12345678')) }
  let(:a_book) { Book.create!(isbn: '13513138568', price: 10) }

  context 'With a new session' do
    context 'and its been 29 minutes since its creation' do
      before do
        Timecop.travel 29.minutes.from_now
      end
      it 'should not be expired' do
        expect(session).not_to be_expired
      end

      context 'and you add a book' do
        before do
          session.add(a_book, 1)
        end

        it 'the cart should have the book' do
          expect(session.cart.occurrences_of(a_book)).to eq 1
        end


        context 'and 10 minutes more has passed' do
          before do
            Timecop.travel 10.minutes.from_now
          end

          it 'the session should not be expired' do
            expect(session).not_to be_expired
          end
        end


        context 'you can' do

          it 'check the ocurrences of a book through session' do
            expect(session.occurrences_of(a_book.id)).to eq 1
          end

          it 'check the total price through session' do
            expect(session.total_price).to eq 10
          end

          it 'check if the cart is empty through session' do
            expect(session.empty?).to be false
          end

          it 'check the total amount of books through session' do
            expect(session.total_amount_of_books).to eq 1
          end

        end
      end
    end

    context 'and its been 30 minutes since its creation' do
      before do
        Timecop.travel 30.minutes.from_now
      end
      it 'should be expired' do
        expect(session).to be_expired
      end

      it 'should raise an error when adding a new book' do
        expect { session.add(a_book, 1) }.to raise_error CartSession.expired_session_error_message
      end

    end
  end
end
