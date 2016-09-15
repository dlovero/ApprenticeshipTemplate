class CartSession < ActiveRecord::Base
  belongs_to :cart
  belongs_to :user

  after_create :update_last_time_used

  def self.for!(a_user)
    self.create!(cart: Cart.create(), user: a_user)
  end

  def update_last_time_used
    self.last_time_used= Time.now
    save!
  end

  def expired?
    Time.now-last_time_used >= 30.minutes
  end

  def list
    assert_active_session
    cart.list
  end

  def add(a_book, quantity)
    self.assert_active_session
    self.update_last_time_used
    cart.add(a_book, quantity.to_i)
  end

  def self.expired_session_error_message
    'The cart has already expired'
  end

  def assert_active_session
    raise ExpiredCartException, self.class.expired_session_error_message if expired?
  end

  def empty?
    cart.empty?
  end

  def total_amount_of_books
    cart.total_amount_of_books
  end

  def occurrences_of(a_book)
    cart.occurrences_of(a_book)
  end

  def total_price
    cart.total_price
  end

  def end
    cart.destroy!
    self.destroy!
  end

end
