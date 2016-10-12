require 'rails_helper'

RSpec.describe UserController, type: :controller do

  describe "POST #challenge" do
    before do
      User.create!(username: 'pirulo')
      User.create!(username: 'pirulais')
    end

    it 'should return succes and the board' do
      post :challenge, username: 'pirulo', challenger: 'pirulais'
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq({"id" => 1, "turn" => 0, "winner" => "NO WINNER", "squares" => [{"x" => 0, "y" => 0, "mark" => "EMPTY"}, {"x" => 0, "y" => 1, "mark" => "EMPTY"}, {"x" => 0, "y" => 2, "mark" => "EMPTY"}, {"x" => 1, "y" => 0, "mark" => "EMPTY"}, {"x" => 1, "y" => 1, "mark" => "EMPTY"}, {"x" => 1, "y" => 2, "mark" => "EMPTY"}, {"x" => 2, "y" => 0, "mark" => "EMPTY"}, {"x" => 2, "y" => 1, "mark" => "EMPTY"}, {"x" => 2, "y" => 2, "mark" => "EMPTY"}]})
    end
  end

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
      post :create_user, username: 'cacho'
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq({'username' => 'cacho'})
    end
  end

end
