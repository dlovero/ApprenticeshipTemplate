require 'matrix.rb'

class Board


  LIMIT = 3

  def initialize
    @turn = 0
    @board_positions = Matrix.build(LIMIT, LIMIT) { nil }
  end


  def empty?
    @board_positions.all? { |value| value.nil? }
  end

  def put_mark_on(y, x)
    assert_game_is_not_over
    assert_board_is_not_full
    assert_coordinates_are_inside_the_board(y, x)
    assert_the_spot_is_empty(y, x)
    mark = select_mark_to_put
    @board_positions[y, x]=mark
    increase_turn
  end

  def get_mark_on(y, x)
    @board_positions[y, x]
  end

  def full?
    @board_positions.all? { |value| played_mark(value) }
  end

  def played_mark(value)
    value == 'X' || value == 'O'
  end


  def fill_with_draw_game
    @board_positions = Matrix.columns([['X', 'O', 'X'], ['X', 'O', 'O'], ['O', 'X', 'X']])
    # X X O
    # O O X
    # X O X
  end

  def fill_with_won_game_by_X
    put_mark_on(0,2) #X
    put_mark_on(1,1) #O
    put_mark_on(1,2) #X
    put_mark_on(2,1) #O
    put_mark_on(2,2) #X
    #     X
    #   O X
    #   O X
  end

  def draw?
    full? && !won?
  end

  def won?
    any_column_has_win_sequence || any_row_has_win_sequence || any_diagonal_has_win_sequence
  end


  #######################################################################################################

  private

  def any_diagonal_has_win_sequence
    all_diagonals.all? do |diagonal|
      has_a_win_sequence(diagonal)
    end
  end

  def all_diagonals
    diagonal_vectors
  end

  def increase_turn
    @turn+=1
  end

  def select_mark_to_put
    if @turn.even?
      mark = 'X'
    else
      mark = 'O'
    end
    mark
  end

  def all_rows
    @board_positions.row_vectors
  end

  def any_column_has_win_sequence
    all_columns.any? do |column|
      has_a_win_sequence(column)
    end
  end

  def has_a_win_sequence(array)
    all_marks_are_X(array) || all_marks_are_O(array)
  end

  def all_marks_are_X(array)
    array.all? { |value| value == 'X' }
  end

  def all_marks_are_O(array)
    array.all? { |value| value == 'O' }
  end

  def all_columns
    @board_positions.column_vectors
  end

  def diagonal_vectors
    array_result = []
    array_result.push(diagonal, inverse_diagonal)
    array_result
  end

  def inverse_diagonal
    diagonal = []
    diagonal.push(@board_positions[0, 2])
    diagonal.push(@board_positions[1, 1])
    diagonal.push(@board_positions[2, 0])
    diagonal
  end

  def diagonal
    diagonal = []
    diagonal.push(@board_positions[0, 0])
    diagonal.push(@board_positions[1, 1])
    diagonal.push(@board_positions[2, 2])
    diagonal
  end

  def assert_game_is_not_over
    raise GameOverException, "Game Over" if won?
  end

  def assert_board_is_not_full
    raise FullException, "The board is full" if full?
  end

  def assert_coordinates_are_inside_the_board(y, x)
    raise SpotOutOfRangeException, 'You tried to mark a spot out of the board' if y>=LIMIT || x>=LIMIT
  end

  def assert_the_spot_is_empty(y, x)
    raise SameSpotException, 'You tried to mark a spot already in use' if get_mark_on(y, x) != nil
  end

  def any_row_has_win_sequence
    all_rows.any? do |row|
      has_a_win_sequence(row)
    end
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



class Matrix

  def []=(i, j, x)
    @rows[i][j] = x
  end

end