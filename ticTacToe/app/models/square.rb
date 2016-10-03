class Square < ActiveRecord::Base
  belongs_to :board

  EMPTY = 'EMPTY'

  O = 'O'

  X = 'X'

  def put_mark_on_square(mark)
    update!(mark: mark)
  end

  def empty_mark?
    self.mark == EMPTY
  end

  def played_mark?
    self.mark == X || self.mark == O
  end

end
