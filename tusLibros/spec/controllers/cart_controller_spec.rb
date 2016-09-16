require 'rails_helper'

RSpec.describe CartController, type: :controller do
  let(:a_user) { User.create!(user_name: 'tester', password: '1234567') }
  before do
    Book.create!(title: 'El hombre de la mascara de hierro', isbn: '1234567890', price: 20)
    CreditCard.create!(credit_card_owner: 'Pepe Grillo', credit_card_number: '1234567890123456', expiration_date: Date.new(3030, 12, 1), user: a_user)
  end

  context 'When receiving a request to create a new cart' do
    before do
      post :create, {login: login_params}
    end

    context 'and you receive a valid login id and password' do
      let(:login_params) { {id: 1, password: '1234567'} }

      it 'should respond with the cart id' do
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to eq({"id" => Cart.last.id})
      end
    end

    context 'and you receive wrong credentials' do
      let(:login_params) { {id: 2, password: '1234567'} }

      it 'should respond with unauthorized error' do
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to eq({"error" => "Couldn't find User"})
      end
    end
  end

  context 'When adding a book to a cart' do
    let!(:cart_session) {CartSession.for!(a_user)}

    before do
      post :add, cartId: cart_id, bookIsbn: book_isbn, bookQuantity: 10
    end

    context 'and the book does exist in the editorial' do
      let(:book_isbn) { '1234567890' }
      let!(:cart_id) { cart_session.cart_id }

      it 'should respond with ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'the cart should have the new book' do
        expect(cart_session).not_to be_empty
      end
    end

    context 'and the cart does not exist' do
      let(:book_isbn) { '1234567890' }
      let(:cart_id) { cart_session.cart_id + 1 }

      it 'should respond not error' do
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({"error" => "Couldn't find CartSession"})
      end
    end

    context 'and you cannot add it due to bad isbn' do
      let(:book_isbn) { '123456777' }
      let(:cart_id) { cart_session.cart_id }

      it 'should return not found error' do
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({"error" => "Couldn't find Book"})
      end
    end
  end

  context 'When listing a cart' do
    before do
      post :create, {login: {id: 1, password: '1234567'}}
      post :add, cartId: 1, bookIsbn: '1234567890', bookQuantity: 10
    end

    context 'and you can list it' do
      it 'should respond a JSON with the list of books on that cart' do
        post :show, cartId: '1'
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq([{"isbn" => "1234567890", "amount_of_books" => 10}])
      end
    end

    context 'and you cannot list it' do
      it 'should respond a json with error and bad request' do
        post :show, cartId: 2
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({"error" => "Couldn't find CartSession"})
      end
    end
  end

  context 'When checking out a cart' do
    before do
      post :create, {login: {id: 1, password: '1234567'}}
      post :add, cartId: 1, bookIsbn: '1234567890', bookQuantity: 10
    end
    context 'and you can check it out' do
      it 'should return a json with the check out data' do
        post :checkout, {cartId: '1', credit_card: {credit_card_number: '1234567890123456', expiration_date: Date.new(3030, 12, 1), credit_card_owner: 'Pepe Grillo'}}
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({"transaction_id" => 1})
        expect(CartSession.find_by(user: a_user)).to be_nil #NO MORE SESSION
      end
    end
    context 'and you cannot check it out because the cart is invalid' do
      it 'should return an error' do
        post :checkout, {cartId: 2, credit_card: {credit_card_number: '1234567890123456', expiration_date: Date.new(3030, 12, 1), credit_card_owner: 'Pepe Grillo'}}
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({"error" => "Couldn't find CartSession"})
      end

      it 'should return an error because the credit card is invalid' do
        post :checkout, {cartId: '1', credit_card: {credit_card_number: '123', expiration_date: Date.new(3030, 12, 1), credit_card_owner: 'Pepe Grillo'}}
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({"error" => "Validation failed: Credit card number Invalid credit card number"})
      end
    end
  end

  context 'When 30 or more minutes passed after the creation of the Cart Session' do
    let!(:cart_session) {CartSession.for!(a_user)}

    before do
      Timecop.travel 30.minutes.from_now
    end

    context 'and you request to add a book to the cart' do
      before do
        post :add, cartId: cart_session.cart_id, bookIsbn: '1234567890', bookQuantity: 10
      end
      it 'should respond with error' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end