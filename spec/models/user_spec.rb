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
  end
end
