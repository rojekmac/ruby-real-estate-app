require "application_system_test_case"

class ListingsTest < ApplicationSystemTestCase
  setup do
    # Ensure there are properties in the DB for all filter types
    Property.create!(property_type: "house", price: 300_000, bedrooms: 3, bathrooms: 2, address: "123 Main St", description: "Test house")
    Property.create!(property_type: "apartment", price: 200_000, bedrooms: 2, bathrooms: 1, address: "456 Oak Ave", description: "Test apartment")
    Property.create!(property_type: "condo", price: 500_000, bedrooms: 4, bathrooms: 3, address: "789 Pine Rd", description: "Test condo")
    Property.create!(property_type: "townhouse", price: 400_000, bedrooms: 3, bathrooms: 2, address: "101 Elm St", description: "Test townhouse")
  end

  test "filtering by type" do
    visit pages_listings_path
    select "Haus", from: "property-type"
    click_on "Filter anwenden"
    assert_text "Test house"
    refute_text "Test apartment"
    refute_text "Test condo"
    refute_text "Test townhouse"
  end

  test "filtering by price range" do
    visit pages_listings_path
    select "200.000 € - 400.000 €", from: "price-range"
    click_on "Filter anwenden"
    assert_text "Test house"
    assert_text "Test townhouse"
    assert_text "Test apartment"
    refute_text "Test condo"
  end

  test "filtering by bedrooms" do
    visit pages_listings_path
    select "4+", from: "bedrooms"
    click_on "Filter anwenden"
    assert_text "Test condo"
    refute_text "Test house"
    refute_text "Test apartment"
    refute_text "Test townhouse"
  end

  test "filtering by bathrooms" do
    visit pages_listings_path
    select "3+", from: "bathrooms"
    click_on "Filter anwenden"
    assert_text "Test condo"
    refute_text "Test house"
    refute_text "Test apartment"
    refute_text "Test townhouse"
  end

  test "reset filters shows all properties" do
    visit pages_listings_path
    select "Haus", from: "property-type"
    click_on "Filter anwenden"
    click_on "Filter zurücksetzen"
    assert_text "Test house"
    assert_text "Test apartment"
    assert_text "Test condo"
    assert_text "Test townhouse"
  end

  test "pagination works" do
    # Create enough properties to require pagination
    per_page = 6
    extra_count = 10
    extra_properties = []
    extra_count.times do |i|
      extra_properties << Property.create!(property_type: "house", price: 100_000 + i * 10_000, bedrooms: 2, bathrooms: 1, address: "PageTest#{i}", description: "Page test #{i}")
    end
    visit pages_listings_path
    # Kaminari orders by created_at: :desc, so the newest (highest i) is first
    assert_text "Page test 9"
    refute_text "Page test 0"
    click_on "Weiter"
    # Should see the next set of properties
    assert_text "Page test 3"
    refute_text "Page test 9"
    # Go to the last page
    last_page = ((Property.count - 1) / per_page) + 1
    click_on last_page.to_s
    # The oldest property should be present
    last_property = Property.order(:created_at).first
    assert_text last_property.description
  end

  # test "visiting the index" do
  #   visit listings_url
  #
  #   assert_selector "h1", text: "Listings"
  # end
end
