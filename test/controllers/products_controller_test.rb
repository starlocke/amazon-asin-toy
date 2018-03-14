require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "fetch tool post" do
    post "/products/fetch_batch", xhr: true, params: {asins: ["foo"]}
    assert_equal "{\"status\":\"ok\"}", @response.body
    assert_equal "application/json", @response.content_type
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      random_asin = (0...12).map{ ('a'..'z').to_a[rand(26)] }.join
      post products_url, params: { product: { asin: random_asin, category: @product.category, item_height: @product.item_height, item_height_units: @product.item_height_units, item_length: @product.item_length, item_length_units: @product.item_length_units, item_width: @product.item_width, item_width_units: @product.item_width_units, package_height: @product.package_height, package_height_units: @product.package_height_units, package_length: @product.package_length, package_length_units: @product.package_length_units, package_width: @product.package_width, package_width_units: @product.package_width_units, rank: @product.rank } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: { asin: @product.asin, category: @product.category, item_height: @product.item_height, item_height_units: @product.item_height_units, item_length: @product.item_length, item_length_units: @product.item_length_units, item_width: @product.item_width, item_width_units: @product.item_width_units, package_height: @product.package_height, package_height_units: @product.package_height_units, package_length: @product.package_length, package_length_units: @product.package_length_units, package_width: @product.package_width, package_width_units: @product.package_width_units, rank: @product.rank } }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
