class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  # Validates that the password has a minimum length of 6 characters. This validation is only applied
  # if it's a new record (i.e., creating a new user) or if the password is being changed (not nil).
  # This conditional validation is important for allowing users to update their profiles without
  # changing their passwords, as well as enforcing password strength for security.
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
end