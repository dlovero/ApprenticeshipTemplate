require 'rails_helper'

RSpec.describe Board, type: :model do

  context 'When having a new game' do
    let(:a_board) { Board.create! }

    it 'should be empty' do
      expect(a_board).to be_empty
    end

    context 'and a player makes a play on a valid' do
      before do
        a_board.put_mark_on({y: 2, x: 2})
      end
      it 'should have an X on that spot because is the first play' do
        byebug
        expect(a_board.get_mark_on({y: 2, x: 2})).to eq 'X'
      end

      context 'and another player makes a play on another valid spot' do
        before do
          a_board.put_mark_on({y: 2, x: 1})
        end
        it 'should have a O in it' do
          expect(a_board.get_mark_on({y: 2, x: 1})).to eq 'O'
        end
      end

      context 'and another player makes a play on the same spot' do
        it 'should raise an exception' do
          expect { a_board.put_mark_on({y: 2, x: 2}) }.to raise_error(Board::SameSpotException)
        end
      end
    end

    context 'and a player tries to mark on an invalid spot' do
      it 'should raise an exception' do
        expect { a_board.put_mark_on({y: 3, x: 3}) }.to raise_error(Board::SpotOutOfRangeException)
      end
    end

    context 'and the players fill every spot resulting in a draw game' do
      before do
        a_board.fill_with_draw_game
        # X X O
        # O O X
        # X O X
      end

      it 'should be full' do
        expect(a_board).to be_full
      end

      it 'should be draw' do
        expect(a_board).to be_draw
      end

      it 'should raise an exception if someone tries to score' do
        expect { a_board.put_mark_on({y: 2, x: 1}) }.to raise_error(Board::FullException)
      end
    end

    context 'and the players fill every spot resulting in a won game' do
      before do
        a_board.fill_with_won_game_by_X
        #     X
        #   O X
        #   O X
      end

      it 'should be won by X' do
        expect(a_board).to be_won
      end

      it 'should not be full' do
        expect(a_board).not_to be_full
      end

      it 'should raise an exception if a player tries to score' do
        expect { a_board.put_mark_on({y: 2, x: 2}) }.to raise_error Board::GameOverException
      end
    end

  end
end