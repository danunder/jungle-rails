require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before :each do
      @user = User.new(
        first_name: 'Bob',
        last_name: 'Danson', 
        email: 'bobdanson@me.co', 
        password: 'sw0rdf1sh', 
        password_confirmation: 'sw0rdf1sh')
    end
    it 'successfully saves a new user when all required information is present' do
      expect(@user.save).to eq true
    end
    it 'fails to save when first name field is omitted' do
      @user.first_name = ''
      expect(@user.save).to eq false
      expect(@user.errors.messages[:first_name]).to eq ["can't be blank"]
    end
    it 'fails to save when last name field is omitted' do
      @user.last_name = nil
      expect(@user.save).to eq false
      expect(@user.errors.messages[:last_name]).to eq ["can't be blank"]
    end
    it 'fails to save when email field is omitted' do
      @user.email = nil
      expect(@user.save).to eq false
      expect(@user.errors.messages[:email]).to eq ["can't be blank"]
    end
    it 'fails to save when the password and password confirmation do not match' do
      @user.password_confirmation = 'swordfish'
      expect(@user.save).to eq false
      expect(@user.errors.messages[:password_confirmation]).to eq ["doesn't match Password"]
    end
    it 'fails to save when the email address is already in the database' do
      expect(@user.save).to eq true
      @user_two = User.new(
        first_name: 'Bob',
        last_name: 'Danson', 
        email: 'bobdanson@me.co', 
        password: 'sw0rdf1sh', 
        password_confirmation: 'sw0rdf1sh'
      )
    expect(@user_two.save).to eq false
    expect(@user_two.errors.messages[:email]).to eq ["has already been taken"]
    end
    it 'fails to save when the password has a length less than eight characters' do
      @user.password = '1234'
      @user.password_confirmation = '1234'
      expect(@user.save).to eq false
    end
  end
  describe 'Authenticate with credentials' do
    before :each do
      @user = User.create(
        first_name: 'Bob',
        last_name: 'Danson', 
        email: 'BobDanson@me.co', 
        password: 'sw0rdf1sh', 
        password_confirmation: 'sw0rdf1sh')
    end
    it 'returns a user when correct credentials are submitted' do
      @user_two = User.authenticate_with_credentials('BobDanson@me.co', 'sw0rdf1sh')
      expect(@user_two.last_name).to eq ('Danson')
    end
     it 'returns nil when email cannot be found' do
      @user_two = User.authenticate_with_credentials('DanBobson@me.co', 'sw0rdf1sh')
      expect(@user_two).to be_nil
    end
    it 'returns nil when password does not match' do
      @user_two = User.authenticate_with_credentials('BobDanson@me.co', 'swordfish')
      expect(@user_two).to be_nil
    end
    it 'returns a user when correct credentials are submitted regardless of email capitalisation' do
      @user_two = User.authenticate_with_credentials('bobdanson@me.co', 'sw0rdf1sh')
      expect(@user_two).not_to be_nil
    end
    it 'returns a user when correct credentials are submitted regardless of trailing or leading spaces in email field' do
      @user_two = User.authenticate_with_credentials('  bobdanson@me.co  ', 'sw0rdf1sh')
      expect(@user_two).not_to be_nil
    end
  end
end
