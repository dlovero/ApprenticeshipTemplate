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

  def put_mark_on(x, y)
    assert_coordinates_are_inside_the_board(x, y)
    assert_the_spot_is_empty(x, y)
    mark = select_mark_to_put
    @board_positions[x, y]=mark
    increase_turn
  end

  def get_mark_on(x, y)
    @board_positions[x, y]
  end

  def full?
    @board_positions.all? { |value| played_mark(value)
    }
  end

  def played_mark(value)
    value == 'X' || value == 'O'
  end


  def fill_with_draw_game
    @board_positions = Matrix.columns([['X','O','X'],['X','O','O'],['O','X','X']])
  end

  def draw?
    full? && !winner?
  end

  def winner?
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

  def assert_coordinates_are_inside_the_board(x, y)
    raise OutOfBoardGameException, 'You tried to mark a spot out of the board' if x>=LIMIT || y>=LIMIT
  end

  def assert_the_spot_is_empty(x, y)
    raise SameSpotGameException, 'You tried to mark a spot already in use' if get_mark_on(x, y) != nil
  end

  def any_row_has_win_sequence
    all_rows.any? do |row|
      has_a_win_sequence(row)
    end
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

end

class Matrix

  def []=(i, j, x)
    @rows[i][j] = x
  end

end