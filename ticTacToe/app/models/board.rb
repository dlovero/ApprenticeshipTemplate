require 'matrix.rb'


class Board < ActiveRecord::Base

  def set_position_to(position, value)

      self.value0 = value

    end
  end

  def board_positions
    {
        [0, 0] => self.value0,
        [0, 1] => self.value1,
        [0, 2] => self.value2,
        [1, 0] => self.value3,
        [1, 1] => self.value4,
        [1, 2] => self.value5,
        [2, 0] => self.value6,
        [2, 1] => self.value7,
        [2, 2] => self.value8
    }
  end

  LIMIT = 3

  after_create :initialize_all_things

  def initialize_all_things
    self.winner = "NO WINNER"
    self.turn = 0
    self.value0 = 'C'
    self.value1 = 'C'
    self.value2 = 'C'
    self.value3 = 'C'
    self.value4 = 'C'
    self.value5 = 'C'
    self.value6 = 'C'
    self.value7 = 'C'
    self.value8 = 'C'
    save!
  end

  def boardPositions
    board_positions
  end

  def empty?
    board_positions.all? { |value| value.nil? }
  end

  def put_mark_on(hash)
    execute_assertions(hash)
    persist_mark(hash)
    increase_turn
  end

  def persist_mark(hash)
    board_positions[[hash[:y], hash[:x]]]=select_mark_to_put
    save!
    puts board_positions[[hash[:y], hash[:x]]]
    puts select_mark_to_put
  end

  def execute_assertions(hash)
    assert_game_is_not_over
    assert_board_is_not_full
    assert_coordinates_are_inside_the_board(hash[:y], hash[:x])
    assert_the_spot_is_empty(hash)
  end

  def get_mark_on(hash)
    board_positions[[hash[:y], hash[:x]]]
  end

  def full?
    board_positions.all? { |value| played_mark(value) }
  end

  def played_mark(value)
    value == 'X' || value == 'O'
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

  def increase_turn
    self.turn+=1
    save!
  end

  def select_mark_to_put
    if turn.even?
      mark = 'X'
    else
      mark = 'O'
    end
    mark
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
    columns=[]
    column=[]
    LIMIT.times do |j|
      LIMIT.times do |i|
        column.push(board_positions[[j, i]])
      end
      columns.push column
      column=[]
    end
    columns
  end

  def all_rows
    rows=[]
    row=[]
    LIMIT.times do |j|
      LIMIT.times do |i|
        row.push(board_positions[[i, j]])
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
    diagonal.push(board_positions[[0, 2]])
    diagonal.push(board_positions[[1, 1]])
    diagonal.push(board_positions[[2, 0]])
    diagonal
  end

  def diagonal
    diagonal = []
    diagonal.push(board_positions[[0, 0]])
    diagonal.push(board_positions[[1, 1]])
    diagonal.push(board_positions[[2, 2]])
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

  def assert_the_spot_is_empty(hash)
    raise SameSpotException, 'You tried to mark a spot already in use' if get_mark_on(hash) != 'C'
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



