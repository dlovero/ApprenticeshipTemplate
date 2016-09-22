class CreditCard < ActiveRecord::Base
  belongs_to :user

  def self.error_message_for_invalid_credit_card_number
    'Invalid credit card number'
  end

  def self.error_message_for_invalid_credit_card_owner
    'Invalid credit card owner'
  end

  def self.error_message_for_expired_credit_card
    'The credit card is expired'
  end

  validates :credit_card_number, format: {with: /[0-9]{16}/,
                                          message: CreditCard.error_message_for_invalid_credit_card_number}

  validates :credit_card_owner,
            format: {with: /[a-zA-Z ]{1,30}/, message: CreditCard.error_message_for_invalid_credit_card_owner},
            length: {maximum: 30, message: CreditCard.error_message_for_invalid_credit_card_owner}

  validate :expiration_of_credit_card


  def expiration_of_credit_card
    errors.add(:expiration_date, CreditCard.error_message_for_expired_credit_card) if expiration_date < Date.today
  end

  def self.find_or_create!(hash)
    hash[:expiration_date]=Date.parse(hash[:expiration_date])
    self.find_or_create_by!(hash)
  end

end
