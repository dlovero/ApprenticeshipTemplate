require 'rails_helper'

RSpec.describe UserController, type: :controller do

  describe "GET #login" do
    before do
      User.create!(username: 'pirulo')
    end

    it "returns http success" do
      get :login, username: 'pirulo'
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq({'username' => 'pirulo'})
    end

    it "explodes due to not found" do
      expect { get :login, username: 'pirula' }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "POST #create_user" do
    it 'returns the new user' do
      post :create_user, username:'cacho'
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq({'username' => 'cacho'})
    end
  end

end
