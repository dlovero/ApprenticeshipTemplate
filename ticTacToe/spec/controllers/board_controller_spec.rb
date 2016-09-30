require 'rails_helper'

RSpec.describe BoardController, type: :controller do

  context 'When starting a new game' do
    before do
      post :new_game
    end
    let(:id) { 1 }

    it 'it should return' do
      expect(response).to have_http_status :ok
      expect(JSON(response.body)).to eq({"boardPositions" => [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]], "id" => 1, "turn" => 0, "winner" => "NO WINNER"})
    end

    context 'and someones mark on 0,0' do
      before do
        post :put_mark, id: id, position: {y: 0, x: 0}
      end

      it 'should return a board with a the spot marked with X' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body)).to eq({"boardPositions" => [['X', nil, nil], [nil, nil, nil], [nil, nil, nil]], "id" => 1, "turn" => 1, "winner" => "NO WINNER"})
      end
    end

    context 'and the player X is about to win' do

      before do
        board = Board.find(id)
        board.fill_with_almost_won_game_by_X
        post :put_mark, id: id, position: {y: 2, x: 2}
      end

      it 'should respond the board but with te winner' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body)).to eq({"boardPositions" => [['X', nil, nil], [nil, nil, nil], [nil, nil, nil]], "id" => 1, "turn" => 1, "winner" => "X WON"})
      end

    end


  end

end
