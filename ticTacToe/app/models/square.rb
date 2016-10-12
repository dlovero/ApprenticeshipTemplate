class Square < ActiveRecord::Base
  belongs_to :board

  def put_mark_on_square(mark)
    update!(mark: mark)
  end

  def empty_mark?
    self.mark == Board::EMPTY
  end

  def played_mark?
    self.mark == Board::X || self.mark == Board::O
  end

end
