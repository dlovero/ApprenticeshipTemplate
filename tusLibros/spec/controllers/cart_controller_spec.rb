require 'rails_helper'

RSpec.describe CartController, type: :controller do
  let(:a_user) { User.create!(user_name: 'tester', password: '1234567') }
  before do
    Book.create!(title: 'El hombre de la mascara de hierro', isbn: '1234567890', price: 20)
    CreditCard.create!(credit_card_owner: 'Pepe Grillo', credit_card_number: '1234567890123456', expiration_date: Date.new(3030, 12, 1), user: a_user)
  end

  context 'When receiving a request to create a new cart' do


    context 'and you can create it' do
      it 'should respond with the cart id' do
        post :create, userId: 1, password: '1234567'
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to eq({"id" => 1})
      end
    end

    context 'and you cannot create it' do
      it 'should respond with error' do
        post :create, userId: 2, password: '1234567'
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({"error" => "Couldn't find User"})
      end
    end
  end

  context 'When adding a book to a cart' do
    before do
      post :create, userId: 1, password: '1234567'
    end

    context 'and you can add it' do
      it 'should respond a header with success' do
        post :add, cartId: '1', bookIsbn: '1234567890', bookQuantity: 10
        expect(response).to have_http_status(:ok)
      end
    end

    context 'and you cannot add it' do
      it 'should respond a header with failure, and a body with the error' do
        post :add, cartId: '2', bookIsbn: '1234567890', bookQuantity: 10
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({"error" => "Couldn't find CartSession"})
        post :add, cartId: '1', bookIsbn: '123456777', bookQuantity: 10
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({"error" => "Couldn't find Book"})
      end
    end

    context 'and the cart is expired' do
      it 'should respond a header with error' do
        Timecop.travel 30.minutes.from_now
        post :add, cartId: '1', bookIsbn: '1234567890', bookQuantity: 10
      end
    end

  end

  context 'When listing a cart' do
    before do
      post :create, userId: 1, password: '1234567'
      post :add, cartId: 1, bookIsbn: '1234567890', bookQuantity: 10
    end

    context 'and you can list it' do
      it 'should respond a JSON with the list of books on that cart' do
        post :show, cartId: '1'
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq([{"ISBN" => "1234567890", "AMOUNT" => 10}])
      end
    end

    context 'and you cannot list it' do
      it 'should respond a json with error and bad request' do
        post :show, cartId: '2'
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({"error" => "Couldn't find CartSession"})
      end
    end
  end

  context 'When checking out a cart' do
    before do
      post :create, userId: 1, password: '1234567'
      post :add, cartId: 1, bookIsbn: '1234567890', bookQuantity: 10
    end
    context 'and you can check it out' do
      it 'should return a json with the check out data' do
        post :checkout, cartId: '1', ccn: '1234567890123456', cced: Date.new(3030, 12, 1), cco: 'Pepe Grillo'
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({"TRANSACTION_ID" => 1})
        expect(CartSession.find_by(user: a_user)).to be_nil #NO MORE SESSION
      end
    end
    context 'and you cannot check it out' do
      it 'should return an error' do
        post :checkout, cartId: '2', ccn: '1234567890123456', cced: Date.new(3030, 12, 1), cco: 'Pepe Grillo'
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({"error" => "Couldn't find CartSession"})

        post :checkout, cartId: '1', ccn: '123', cced: Date.new(3030, 12, 1), cco: 'Pepe Grillo'
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({"error" => "Validation failed: Credit card number Invalid credit card number"})
      end
    end
  end

end