require 'rails_helper'

RSpec.describe CartController, type: :controller do
  before do
    User.create!(user_name: 'tester', password: '1234567')
    Book.create!(title: 'El hombre de la mascara de hierro', isbn: '1234567890', price: 20)
    CreditCard.create!(credit_card_owner: 'Pepe Grillo', credit_card_number: '1234567890123456', expiration_date: Date.new(3030, 12, 1), user_id: 1)
  end

  context 'When receiving a request to create a new cart' do


    context 'and you can create it' do
      it 'should respond with the cart id' do
        post :new, userId: 1, password: '1234567'
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to eq({"id" => 1})
      end
    end

    context 'and you cannot create it' do
      it 'should respond with error' do
        post :new, userId: 2, password: '1234567'
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({"error" => "Could not create"})
      end
    end
  end

  context 'When adding a book to a cart' do
    before do
      post :new, userId: 1, password: '1234567'
    end

    context 'and you can add it' do
      it 'should respond a header with success' do
        post :add, cartId: '1', bookIsbn: '1234567890', bookQuantity: 10
        expect(response).to have_http_status(:ok)
      end
    end

    context 'and you cannot add it' do
      it 'should respond a header with failure, and a body with the error' do
        post :add, cartId: '2', bookIsbn: '123455666', bookQuantity: 10
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({"error" => "Could not add"})
      end
    end
  end

  context 'When listing a cart' do
    before do
      post :new, userId: 1, password: '1234567'
      post :add, cartId: 1, bookIsbn: '1234567890', bookQuantity: 10
    end

    context 'and you can list it' do
      it 'should respond a JSON with the list of books on that cart' do
        post :list, cartId: '1'
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({"1" => ["1234567890" => 10]})
      end
    end

    context 'and you cannot list it' do
      it 'should respond a json with error and bad request' do
        post :list, cartId: '2'
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({"error" => 'Could not list'})
      end
    end
  end

  context 'When checking out a cart' do
    before do
      post :new, userId: 1, password: '1234567'
      post :add, cartId: 1, bookIsbn: '1234567890', bookQuantity: 10
    end
    context 'and you can check it out' do
      it 'should return a json with the check out data' do
        post :checkout, cartId: '1', ccn: '1234567890123456', cced: Date.new(3030, 12, 1), cco: 'Pepe Grillo'
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({"TRANSACTION_ID" => 1})
      end
    end
    context 'and you cannot check it out' do
      it 'should return an error' do
        post :checkout, cartId: '2', ccn: '1234567890123456', cced: Date.new(3030, 12, 1), cco: 'Pepe Grillo'
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({"error" => "Could not checkout"})
      end
    end
  end
end