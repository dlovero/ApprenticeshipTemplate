require 'matrix.rb'

class Board

  attr_reader :board_positions

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
    @board_positions.all? {|value| value == 'X' || value == 'O'}
  end


  def fill_with_draw_game
    @board_positions.each_with_index do |value,row,column| put_mark_on(row,column)  end
  end

  def draw?
    full? && !winner?
  end

  def winner?
    true #keep from here tomorrow
  end

  #######################################################################################################

  private

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
    raise OutOfBoardGameException, 'You tried to mark a spot out of the board' if x>LIMIT || y>LIMIT
  end

  def assert_the_spot_is_empty(x, y)
    raise SameSpotGameException, 'You tried to mark a spot already in use' if get_mark_on(x, y) != nil
  end
end

class Matrix
  def []=(i, j, x)
    @rows[i][j] = x
  end
end