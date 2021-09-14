class User < ApplicationRecord

  has_secure_password

  validates :email, presence: true
  # Below, used the solution suggested here: https://stackoverflow.com/questions/38611405/email-validation-in-ruby-on-rails
  # But validates user@gmailcom (without .) -> is this ok? Shouldn't be according to: https://help.returnpath.com/hc/en-us/articles/220560587-What-are-the-rules-for-email-address-syntax-
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email, uniqueness: true
  validates :role, inclusion: { in: %w(registered admin) }

  after_initialize :default_role!
  before_validation :downcase_email


  private

  def downcase_email
    self.email = email.downcase
  end

  def default_role!
    self.role ||= 'registered'
  end

end
