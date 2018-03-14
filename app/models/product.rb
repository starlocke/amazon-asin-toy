require "rapa"

class Product < ApplicationRecord
    # ASIN should be not-nil.
    validates :asin, presence: true

    # Works on POST /products/fetch_batch
    #
    # Configuration: See README.md for "how to configure Amazon Access Keys".
    def self.fetch_batch(asins)
        client = Rapa::Client.new(
            access_key_id: ENV["AMAZON_ACCESS_KEY_ID"],
            associate_tag: ENV["AMAZON_ASSOCIATE_TAG"],
            secret_access_key: ENV["AMAZON_SECRET_ACCESS_KEY"],
        )

        response = client.list_items(
            item_ids: asins,
            id_type: "ASIN",
            domain: "com",
            response_groups: ["ItemAttributes", "SalesRank"]
        )

        response.each do |response|
            p = Product.find_by(asin: response.asin)
            if p
                Product.update_from_fetch(p, response)
            else
                Product.create_from_fetch(response)
            end
        end # each response
    end

    # A unit-testable "create" method, for the context of a "fetch_batch" operation.
    # nil-values are OK for all fields except ASIN.
    def self.create_from_fetch(response)
        item_width  = response.item_width.nil? ? nil : response.item_width.value
        item_height = response.item_height.nil? ? nil : response.item_height.value
        item_length = response.item_length.nil? ? nil : response.item_length.value
        item_width_units  = response.item_width.nil? ? nil : response.item_width.units
        item_height_units = response.item_height.nil? ? nil : response.item_height.units
        item_length_units = response.item_length.nil? ? nil : response.item_length.units
        package_width  = response.package_width.nil? ? nil : response.package_width.value
        package_height = response.package_height.nil? ? nil : response.package_height.value
        package_length = response.package_length.nil? ? nil : response.package_length.value
        package_width_units  = response.package_width.nil? ? nil : response.package_width.units
        package_height_units = response.package_height.nil? ? nil : response.package_height.units
        package_length_units = response.package_length.nil? ? nil : response.package_length.units
        p = Product.create(
            asin: response.asin,
            item_width: item_width,
            item_height: item_height,
            item_length: item_length,
            item_width_units: item_width_units,
            item_height_units: item_height_units,
            item_length_units: item_length_units,
            package_width: package_width,
            package_height: package_height,
            package_length: package_length,
            package_width_units: package_width_units,
            package_height_units: package_height_units,
            package_length_units: package_length_units,
            category: response.product_group,
            rank: response.sales_rank
        )
    end

    # A unit-testable "update" method, for the context of a "fetch_batch" operation.
    # nil-values are OK for all fields!
    def self.update_from_fetch(product, response)
        product.item_width = response.item_width.nil? ? nil : response.item_width.value
        product.item_height = response.item_height.nil? ? nil : response.item_height.value
        product.item_length = response.item_length.nil? ? nil : response.item_length.value
        product.item_width_units = response.item_width.nil? ? nil : response.item_width.units
        product.item_height_units = response.item_height.nil? ? nil : response.item_height.units
        product.item_length_units = response.item_length.nil? ? nil : response.item_length.units
        product.package_width = response.package_width.nil? ? nil : response.package_width.value
        product.package_height = response.package_height.nil? ? nil : response.package_height.value
        product.package_length = response.package_length.nil? ? nil : response.package_length.value
        product.package_width_units = response.package_width.nil? ? nil : response.package_width.units
        product.package_height_units = response.package_height.nil? ? nil : response.package_height.units
        product.package_length_units = response.package_length.nil? ? nil : response.package_length.units
        product.category = response.product_group
        product.rank = response.sales_rank
        product.save
    end
end
