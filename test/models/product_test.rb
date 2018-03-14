require 'test_helper'
require 'ostruct'

class ProductTest < ActiveSupport::TestCase
  test "should not be savable without data" do
    product = Product.new
    assert_not product.save, "Saved product without ASIN"
  end

  test "create and update from fetch" do
    data = { :asin => "test" } # assume that Amazon can provide no other data besides ASIN
    response = OpenStruct.new(data)
    product = Product.create_from_fetch(response)
    assert product

    data = { :asin => "test", category: "test" } # assume that Amazon can provide no other data besides ASIN
    response = OpenStruct.new(data)
    assert Product.update_from_fetch(product, response)
  end
end
