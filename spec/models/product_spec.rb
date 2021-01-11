require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.new(
        name: 'Books'
        )
      @product = @category.products.new(
        name: 'Moby Dick',
        price: 3000,
        quantity: 37       
      )
      end
    it 'saves a product when all validation fields are satisfied' do
        
      expect(@product.save).to eq true
    end
    it 'fails to save and raises an error when the name field is omitted' do
      @product.name = nil
      @product.save
      expect(@product.save).to eq false
      expect(@product.errors.messages[:name]).to eq ["can't be blank"]
    end
    it 'fails to save and raises errors when the price field is omitted' do
      
      @product = Product.new(
        name: 'Moby Dick',
        quantity: 37,
        price: nil,
        category: @category
      )
      @product.save
      expect(@product.save).to eq false
      expect(@product.errors.messages[:price]).to eq ["is not a number", "can't be blank"]
    end
    it 'fails to save and raises an error when the price field is not a number' do
      
      @product = Product.new(
        name: 'Moby Dick',
        price: 'two bucks',
        quantity: 37,
        category: @category
      )
      
      expect(@product.save).to eq false
      expect(@product.errors.messages[:price]).to eq ["is not a number"]
    end
    it 'fails to save and raises errors when the quantity field is omitted' do
      
      @product = Product.create(
        name: 'Moby Dick',
        price: 3000,
        category: @category
      )
      
      expect(@product).not_to be_nil
      expect(@product.errors.messages[:quantity]).to eq ["can't be blank", "is not a number"]
    end
    it 'fails to save and raises an error when the quantity field is not a number' do
      
      @product = Product.new(
        name: 'Moby Dick',
        price: 3000,
        quantity: 'a few',
        category: @category
      )
      @product.save
      expect(@product.save).to eq false
      expect(@product.errors.messages[:quantity]).to eq ["is not a number"]
    end
    it 'fails to save and raises an error when the category field is omitted' do
      
      @product = Product.new(
        name: 'Moby Dick',
        price: 3000,
        quantity: 37        
      )
      @product.save
      expect(@product.save).to eq false
      expect(@product.errors.messages[:category]).to eq ["can't be blank"]
    end
  end
end
