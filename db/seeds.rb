# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Property.create!([
  {
    property_type: 'house',
    price: 450000,
    bedrooms: 3,
    bathrooms: 2,
    address: '123 Maple St, Springfield',
    description: 'Modern family home with pool and garden.'
  },
  {
    property_type: 'apartment',
    price: 380000,
    bedrooms: 2,
    bathrooms: 2,
    address: '456 Oak Ave, Metropolis',
    description: 'Luxury apartment in the city center.'
  },
  {
    property_type: 'townhouse',
    price: 520000,
    bedrooms: 4,
    bathrooms: 3,
    address: '789 Pine Rd, Riverdale',
    description: 'Cozy townhouse with private yard.'
  },
  {
    property_type: 'condo',
    price: 280000,
    bedrooms: 1,
    bathrooms: 1,
    address: '101 Elm St, Downtown',
    description: 'Downtown condo with elevator access.'
  },
  {
    property_type: 'house',
    price: 650000,
    bedrooms: 5,
    bathrooms: 4,
    address: '202 Birch Blvd, Lakeside',
    description: 'Spacious family house with large garden.'
  },
  {
    property_type: 'apartment',
    price: 420000,
    bedrooms: 2,
    bathrooms: 2,
    address: '303 Cedar Ct, Uptown',
    description: 'Modern loft with gym and internet.'
  },
  {
    property_type: 'condo',
    price: 210000,
    bedrooms: 2,
    bathrooms: 1,
    address: '404 Spruce Ln, Midtown',
    description: 'City center condo with security.'
  },
  {
    property_type: 'house',
    price: 320000,
    bedrooms: 3,
    bathrooms: 2,
    address: '505 Willow Way, Suburbia',
    description: 'Suburban house with fireplace.'
  },
  {
    property_type: 'apartment',
    price: 250000,
    bedrooms: 1,
    bathrooms: 1,
    address: '606 Poplar Pl, Cityview',
    description: 'Studio apartment with internet.'
  },
  {
    property_type: 'townhouse',
    price: 410000,
    bedrooms: 3,
    bathrooms: 2,
    address: '707 Aspen Dr, Greenfield',
    description: 'Family townhouse with pet-friendly yard.'
  },
  {
    property_type: 'condo',
    price: 600000,
    bedrooms: 4,
    bathrooms: 3,
    address: '808 Redwood St, Skyline',
    description: 'Luxury penthouse with pool and gym.'
  },
  {
    property_type: 'apartment',
    price: 195000,
    bedrooms: 1,
    bathrooms: 1,
    address: '909 Cypress Ave, Oldtown',
    description: 'Budget apartment with basic amenities.'
  }
])

Property.create!((1..20).map do |i|
  {
    property_type: %w[house apartment condo townhouse].sample,
    price: rand(150_000..900_000),
    bedrooms: rand(1..5),
    bathrooms: rand(1..4),
    address: "#{1000 + i} Test St, City#{i}",
    description: "Sample property ##{i} for pagination testing."
  }
end)
