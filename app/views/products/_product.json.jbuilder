json.extract! product, :id, :asin, :category, :rank, :item_width, :item_height, :item_length, :item_width_units, :item_height_units, :item_length_units, :package_width, :package_height, :package_length, :package_width_units, :package_height_units, :package_length_units, :created_at, :updated_at
json.url product_url(product, format: :json)
