require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    let(:user) do
      User.new(
        name: "FIrst_name Last_name",
        email: 'john.doe@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
    end

    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = User.new(
        name: nil,
        email: 'john.doe@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Name can't be blank")
    end

    it 'is not valid without an email' do
      user.email = nil
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'is not valid without a password' do
      user.password = nil
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'is not valid when password and password_confirmation do not match' do
      user.password_confirmation = 'different123'
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'is not valid with a password shorter than 6 characters' do
      user = User.new(
        name: "John Doe",
        email: 'john@example.com',
        password: 'short',
        password_confirmation: 'short'
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it 'requires a unique email, case insensitive' do
      user.save
      duplicate_user = user.dup
      duplicate_user.email = user.email.upcase
      expect(duplicate_user).not_to be_valid
      expect(duplicate_user.errors.full_messages).to include("Email has already been taken")
    end
  end

  describe '.authenticate_with_credentials' do
    before do
      @user = User.create(
        name: "Example User",
        email: "user@example.com",
        password: "password",
        password_confirmation: "password"
      )
    end

    it 'authenticates successfully with correct credentials' do
      expect(User.authenticate_with_credentials('user@example.com', 'password')).to eq(@user)
    end

    it 'authenticates successfully with spaces around email' do
      expect(User.authenticate_with_credentials('  user@example.com  ', 'password')).to eq(@user)
    end

    it 'authenticates successfully with wrong case email' do
      expect(User.authenticate_with_credentials('USER@EXAMPLE.COM', 'password')).to eq(@user)
    end

    it 'returns nil for authentication with incorrect password' do
      expect(User.authenticate_with_credentials('user@example.com', 'wrongpassword')).to be_nil
    end
  end
end
