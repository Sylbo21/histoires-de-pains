class User < ApplicationRecord

  has_secure_password

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
