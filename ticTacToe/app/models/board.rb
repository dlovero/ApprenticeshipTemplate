class Board < ActiveRecord::Base

  has_many :squares

  LIMIT = 3

  EMPTY = 'EMPTY'

  X = 'X'

  O = 'O'

  NOT_WINNER = "NO WINNER"

  after_create :initialize_things

  def initialize_things
    self.winner = NOT_WINNER
    self.turn = 0
    create_squares
    save!
  end

  def create_squares
    (0...LIMIT).each do |x|
      (0...LIMIT).each do |y|
        Square.create!(x: x, y: y, mark: EMPTY, board_id: id)
      end
    end
  end


  def empty?
    squares.all? { |square| square.empty_mark? }
  end

  def put_mark_on(hash)
    execute_validations(hash[:x], hash[:y])
    put_mark!(hash[:x], hash[:y])
    increase_turn
    set_winner_if_has_one
  end

  def set_winner_if_has_one
    update!(winner: "X WON") if X_won?
    update!(winner: "O WON") if O_won?
    update!(winner: "DRAW") if draw?
  end

  def put_mark!(x, y)
    squares.find_by!(x: x, y: y).put_mark_on_square(select_mark_to_put)
    squares.reload
  end

  def execute_validations(x, y)
    assert_coordinates_are_inside_the_board(x, y)
    assert_board_is_not_full
    assert_game_is_not_over
    assert_the_spot_is_empty(x, y)
  end

  def get_mark_on(x, y)
    assert_coordinates_are_inside_the_board(x, y)
    squares.find_by!(x: x, y: y).mark
  end

  def full?
    squares.all? { |square| square.played_mark? }
  end

  def draw?
    full? && !has_winner?
  end

  def has_winner?
    self.winner != NOT_WINNER
  end

  def X_won?
    columns_have_win_sequence_for(X) || rows_have_win_sequence_for(X) || diagonals_have_win_sequence_for(X)
  end

  def O_won?
    columns_have_win_sequence_for(O) || rows_have_win_sequence_for(O) || diagonals_have_win_sequence_for(O)
  end


  #######################################################################################################

  private

  def diagonals_have_win_sequence_for(mark)
    detect_if_all_are_the_same(all_diagonals, mark)
  end

  def columns_have_win_sequence_for(mark)
    detect_if_all_are_the_same(all_columns, mark)
  end

  def rows_have_win_sequence_for(mark)
    detect_if_all_are_the_same(all_rows, mark)
  end

  def detect_if_all_are_the_same(vectors, mark)
    vectors.any? do |vector|
      has_a_win_sequence(vector, mark)
    end
  end

  def increase_turn
    self.turn+=1
    save!
  end

  def select_mark_to_put
    if turn.even?
      X
    else
      O
    end
  end

  def has_a_win_sequence(array, mark)
    array.all? { |value| value == mark }
  end


  def all_columns
    columns=[]
    column=[]
    (0...LIMIT).each do |x|
      (0...LIMIT).each do |y|
        column.push(get_mark_on(x, y))
      end
      columns.push column
      column=[]
    end
    columns
  end

  def all_rows
    rows=[]
    row=[]
    LIMIT.times do |y|
      LIMIT.times do |x|
        row.push(get_mark_on(x, y))
      end
      rows.push row
      row=[]
    end
    rows
  end

  def all_diagonals
    array_result = []
    array_result.push(diagonal, inverse_diagonal)
    array_result
  end

  def inverse_diagonal
    diagonal = []
    diagonal.push(get_mark_on(2, 2))
    diagonal.push(get_mark_on(1, 1))
    diagonal.push(get_mark_on(0, 0))
    diagonal
  end

  def diagonal
    diagonal = []
    diagonal.push(get_mark_on(0, 2))
    diagonal.push(get_mark_on(1, 1))
    diagonal.push(get_mark_on(2, 0))
    diagonal
  end

  def assert_game_is_not_over
    raise GameOverException, "Game Over" if has_winner?
  end

  def assert_board_is_not_full
    raise FullException, "The board is full" if full?
  end

  def assert_coordinates_are_inside_the_board(x, y)
    raise SpotOutOfRangeException, 'You tried to mark a spot out of the board' if x>=LIMIT || y>=LIMIT
  end

  def assert_the_spot_is_empty(x, y)
    raise SameSpotException, 'You tried to mark a spot already in use' if get_mark_on(x, y) != 'EMPTY'
  end

  class SpotOutOfRangeException < Exception
  end

  class FullException < Exception
  end

  class SameSpotException < Exception
  end

  class GameOverException < Exception
  end

end



