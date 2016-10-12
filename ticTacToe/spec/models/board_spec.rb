require 'rails_helper'



RSpec.describe Board, type: :model do

  context 'When having a new game' do
    let(:player_x){User.create!}
    let(:player_o){User.create!}
    let(:a_board) { Board.create!(player_x: player_x, player_o: player_o) }

    it 'should be empty' do
      expect(a_board).to be_empty
    end

    context 'and a player makes a play on a valid' do
      before do
        a_board.put_mark_on({x: 2, y: 2})
      end
      it 'should have an X on that spot because is the first play' do
        expect(a_board.get_mark_on(2, 2)).to eq 'X'
      end

      context 'and another player makes a play on another valid spot' do
        before do
          a_board.put_mark_on({x: 2, y: 1})
        end
        it 'should have a O in it' do
          expect(a_board.get_mark_on(2, 1)).to eq 'O'
        end
      end

      context 'and another player makes a play on the same spot' do
        it 'should raise an exception' do
          expect { a_board.put_mark_on({x: 2, y: 2}) }.to raise_error(Board::SameSpotException)
        end
      end
    end

    context 'and a player tries to mark on an invalid spot' do
      it 'should raise an exception' do
        expect { a_board.put_mark_on({x: 3, y: 3}) }.to raise_error(Board::SpotOutOfRangeException)
      end
    end

    context 'and the players fill every spot resulting in a draw game' do
      before do
        fill_with_draw_game(a_board)
      end

      it 'should be full' do
         expect(a_board).to be_full
      end

      it 'should have draw state' do
        expect(a_board.winner).to eq "DRAW"
      end

      it 'should raise an exception if someone tries to score' do
        expect { a_board.put_mark_on({y: 2, x: 1}) }.to raise_error(Board::FullException)
      end
    end

    context 'and the players fill every spot resulting in a won game' do
      before do
        fill_with_won_game(a_board)
        #     X
        #   O X
        #   O X
      end

      it 'should be won by X' do
        expect(a_board).to be_has_winner
      end

      it 'should not be full' do
        expect(a_board).not_to be_full
      end

      it 'should raise an exception if a player tries to score' do
        expect { a_board.put_mark_on({y: 0, x: 0}) }.to raise_error Board::GameOverException
      end
    end
  end


  def fill_with_won_game(a_board)
    a_board.put_mark_on({x:2,y:0})
    a_board.put_mark_on({x:1,y:0})
    a_board.put_mark_on({x:2,y:1})
    a_board.put_mark_on({x:1,y:1})
    a_board.put_mark_on({x:2,y:2})
  end

  def fill_with_draw_game(a_board)
    a_board.put_mark_on({x: 1, y: 1})
    a_board.put_mark_on({x: 0, y: 0})
    a_board.put_mark_on({x: 0, y: 1})
    a_board.put_mark_on({x: 0, y: 2})
    a_board.put_mark_on({x: 1, y: 2})
    a_board.put_mark_on({x: 1, y: 0})
    a_board.put_mark_on({x: 2, y: 0})
    a_board.put_mark_on({x: 2, y: 1})
    a_board.put_mark_on({x: 2, y: 2})
  end


end