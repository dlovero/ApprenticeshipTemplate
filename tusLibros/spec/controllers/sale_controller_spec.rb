require 'rails_helper'

RSpec.describe SaleController, type: :controller do
  before do
    a_user=User.create!(user_name: 'tester', password: '1234567')
    a_book=Book.create!(title: 'El hombre de la mascara de hierro', isbn: '1234567890', price: 25)
    another_book=Book.create!(title: 'El gato negro', isbn: '1231231231', price: 20)
    a_credit_card=CreditCard.create!(credit_card_owner: 'Pepe Grillo', credit_card_number: '1234567890123456', expiration_date: Date.new(3030, 12, 1), user: a_user)
    a_cart_session=CartSession.for!(a_user)
    a_cart_session.add(a_book, 10)
    a_cart_session.add(another_book, 11)
    Cashier.new(MerchantProcessor.new).checkout(a_cart_session, a_credit_card)
  end

  context 'When you want to list the purchases of an user' do
    context 'and you can' do
      before do
        post :show, userId: 1, password: '1234567'
      end
      it 'should return a json with a list of all the purchases' do
        expect(response).to have_http_status :ok
        expect(JSON.parse(response.body)).to eq([{"title" => "El hombre de la mascara de hierro", "isbn" => "1234567890", "amount_of_books" => 10, "price" => 25.0},
                                                 {"title" => "El gato negro", "isbn" => "1231231231", "amount_of_books" => 11, "price" => 20.0}])
      end
    end

    context 'and you cant because bad username' do
      before do
        post :show, userId: 2, password: '1234567'
      end
      it 'should return an error' do
        expect(response).to have_http_status :not_found
        expect(JSON.parse(response.body)).to eq({"error" => "Couldn't find User"})
      end
    end
  end

end
