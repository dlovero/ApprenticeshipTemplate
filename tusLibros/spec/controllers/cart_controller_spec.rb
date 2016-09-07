require 'rails_helper'

RSpec.describe CartController, type: :controller do

  let(:a_book) { Book.create!() }
  let(:a_cart) { Cart.create! }

  context 'When requesting to show a cart' do
    before do
      get :list_cart, {id: a_cart.id}
    end

    it 'should have a success response' do
      assert_response :success
    end
  end
end