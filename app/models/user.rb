class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  # Validates that the password has a minimum length of 6 characters. This validation is only applied
  # if were creating a new user or if the password is being created or updated.
  # This conditional validation is important for allowing users to update their profiles without
  # changing their passwords
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  def self.authenticate_with_credentials(email, password)
    # Normalize email by lowercasing and removing leading/trailing whitespace
    email = email.strip.downcase
    user = User.find_by_email(email)
    
    # If the user exists and the password is correct, return the user; otherwise, return nil
    user && user.authenticate(password) ? user : nil
  end
end