require 'rails_helper'

RSpec.describe BookController, type: :controller do

  context 'When listing the catalog' do
    before do
      Book.create!(title:'CCC', isbn: '12345678901', price: 20 )
      Book.create!(title:'DDD', isbn: '12345678902', price: 10 )
      post :index
    end

    it 'it should respond with all the catalog' do
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq([{"isbn"=>"12345678901", "title"=>"CCC", "price"=>20.0}, {"isbn"=>"12345678902", "title"=>"DDD", "price"=>10.0}])
    end

  end

end
