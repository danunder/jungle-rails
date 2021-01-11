require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'saves a product when all validation fields are satisfied' do
      @category = Category.new(
        name: 'Books'
      )
      @product = Product.new(
        name: 'Moby Dick',
        price: 3000,
        quantity: 37,
        category: @category
      )
      expect(@product.save).to eq true
    end
    it 'fails to save and raises an error when the name field is omitted' do
      @category = Category.new(
        name: 'Books'
      )
      @product = Product.new(
        price: 3000,
        quantity: 37,
        category: @category
      )
      @product.save
      expect(@product.save).to eq false
      expect(@product.errors.messages[:name]).to eq ["can't be blank"]
    end
    it 'fails to save and raises errors when the price field is omitted' do
      @category = Category.new(
        name: 'Books'
      )
      @product = Product.new(
        name: 'Moby Dick',
        quantity: 37,
        category: @category
      )
      @product.save
      expect(@product.save).to eq false
      expect(@product.errors.messages[:price]).to eq ["is not a number", "can't be blank"]
    end
    it 'fails to save and raises an error when the price field is not a number' do
      @category = Category.new(
        name: 'Books'
      )
      @product = Product.new(
        name: 'Moby Dick',
        price: 'two bucks',
        quantity: 37,
        category: @category
      )
      @product.save
      expect(@product.save).to eq false
      expect(@product.errors.messages[:price]).to eq ["is not a number"]
    end
    it 'fails to save and raises errors when the price field is not a number' do
      @category = Category.new(
        name: 'Books'
      )
      @product = Product.new(
        name: 'Moby Dick',
        price: 'two bucks',
        quantity: 37,
        category: @category
      )
      @product.save
      expect(@product.save).to eq false
      expect(@product.errors.messages[:price]).to eq ["is not a number"]
    end
  end
end
