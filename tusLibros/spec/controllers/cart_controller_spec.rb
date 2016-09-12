require 'rails_helper'

RSpec.describe CartController, type: :controller do



  context 'When receiving a request to create a new cart' do
    before do
      User.create!(user_name:'tester', password:'1234567')
      Book.create!(title:'El hombre de la mascara de hierro',isbn: '1234567890',price: 20)
    end
    context 'and you can create it' do
      it 'should respond with the cart id' do
        post :new, userId: 1, password: '1234567'
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to eq({"id"=>1})
      end
    end

    context 'and you cannot create it' do
      it' should respond with error' do
        post :new, userId:2, password: '1234567'
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({"error"=>"Could not create"})
      end
    end
  end

  context 'When adding a book to a cart'
  before do
    User.create!(user_name:'tester', password:'1234567')
    Book.create!(title:'El hombre de la mascara de hierro',isbn: '1234567890',price: 20)
    post :new, userId: 1, password: '1234567'
  end

  it 'and you can add it' do
    post :add, cartId:'1',bookIsbn:'1234567890', bookQuantity: 10
    expect(response).to have_http_status(:success)
  end

end