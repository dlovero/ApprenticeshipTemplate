require 'rails_helper'

RSpec.describe BoardController, type: :controller do

  context 'When starting a new game' do
    let(:player_x) { User.create! }
    let(:player_o) { User.create! }
    let!(:a_board) { Board.create!(player_x: player_x, player_o: player_o) }
    let(:id) { 1 }

    context 'and someones mark on 0,0' do
      before do
        post :put_mark, id: id, position: {x: 0, y: 0}
      end

      it 'should return a board with a the spot marked with X' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body)).to eq({"id" => 1, "turn" => 1, "winner" => "NO WINNER", "squares" => [{"x" => 0, "y" => 0, "mark" => "X"}, {"x" => 0, "y" => 1, "mark" => "EMPTY"}, {"x" => 0, "y" => 2, "mark" => "EMPTY"}, {"x" => 1, "y" => 0, "mark" => "EMPTY"}, {"x" => 1, "y" => 1, "mark" => "EMPTY"}, {"x" => 1, "y" => 2, "mark" => "EMPTY"}, {"x" => 2, "y" => 0, "mark" => "EMPTY"}, {"x" => 2, "y" => 1, "mark" => "EMPTY"}, {"x" => 2, "y" => 2, "mark" => "EMPTY"}]})
      end
    end

    context 'and the player O won' do

      before do
        fill_with_won_game_by_O
      end

      it 'should respond the board but with the winner' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body)).to eq({"id" => 1, "turn" => 6, "winner" => "O WON", "squares" => [{"x" => 0, "y" => 0, "mark" => "EMPTY"}, {"x" => 0, "y" => 1, "mark" => "EMPTY"}, {"x" => 0, "y" => 2, "mark" => "X"}, {"x" => 1, "y" => 0, "mark" => "O"}, {"x" => 1, "y" => 1, "mark" => "O"}, {"x" => 1, "y" => 2, "mark" => "O"}, {"x" => 2, "y" => 0, "mark" => "X"}, {"x" => 2, "y" => 1, "mark" => "X"}, {"x" => 2, "y" => 2, "mark" => "EMPTY"}]})
      end
    end

    context 'and the game is draw' do

      before do
        fill_with_draw_game
      end

      it 'should respond the board with the draw' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body)).to eq({"id" => 1, "turn" => 9, "winner" => "DRAW", "squares" => [{"x" => 0, "y" => 0, "mark" => "O"}, {"x" => 0, "y" => 1, "mark" => "X"}, {"x" => 0, "y" => 2, "mark" => "O"}, {"x" => 1, "y" => 0, "mark" => "O"}, {"x" => 1, "y" => 1, "mark" => "X"}, {"x" => 1, "y" => 2, "mark" => "X"}, {"x" => 2, "y" => 0, "mark" => "X"}, {"x" => 2, "y" => 1, "mark" => "O"}, {"x" => 2, "y" => 2, "mark" => "X"}]})
      end
    end

    def fill_with_won_game_by_O
      post :put_mark, id: id, position: {x: 2, y: 0}
      post :put_mark, id: id, position: {x: 1, y: 0}
      post :put_mark, id: id, position: {x: 2, y: 1}
      post :put_mark, id: id, position: {x: 1, y: 1}
      post :put_mark, id: id, position: {x: 0, y: 2}
      post :put_mark, id: id, position: {x: 1, y: 2}
    end

    def fill_with_draw_game
      post :put_mark, id: id, position: {x: 1, y: 1}
      post :put_mark, id: id, position: {x: 0, y: 0}
      post :put_mark, id: id, position: {x: 0, y: 1}
      post :put_mark, id: id, position: {x: 0, y: 2}
      post :put_mark, id: id, position: {x: 1, y: 2}
      post :put_mark, id: id, position: {x: 1, y: 0}
      post :put_mark, id: id, position: {x: 2, y: 0}
      post :put_mark, id: id, position: {x: 2, y: 1}
      post :put_mark, id: id, position: {x: 2, y: 2}
    end

  end
end