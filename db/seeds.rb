# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Clear existing data to prevent duplicates
Property.destroy_all

# Thailand property listings
thailand_properties = [
  {
    property_type: 'house',
    price: 4500000,
    bedrooms: 3,
    bathrooms: 2,
    address: '123 Sukhumvit Road, Bangkok',
    description: 'Modern family home with pool and tropical garden in central Bangkok.'
  },
  {
    property_type: 'apartment',
    price: 3800000,
    bedrooms: 2,
    bathrooms: 2,
    address: '456 Silom Road, Bangkok',
    description: 'Luxury apartment in Bangkok CBD with BTS access.'
  },
  {
    property_type: 'house',
    price: 8500000,
    bedrooms: 4,
    bathrooms: 3,
    address: '789 Chalong Bay, Phuket',
    description: 'Beachfront villa with private pool and stunning ocean views.'
  },
  {
    property_type: 'condo',
    price: 2800000,
    bedrooms: 1,
    bathrooms: 1,
    address: '101 Thapae Road, Chiang Mai',
    description: 'Modern condo in old city Chiang Mai with mountain views.'
  },
  {
    property_type: 'house',
    price: 6500000,
    bedrooms: 5,
    bathrooms: 4,
    address: '202 Nimmanhaemin Road, Chiang Mai',
    description: 'Spacious family house with large garden in trendy Nimman area.'
  },
  {
    property_type: 'apartment',
    price: 4200000,
    bedrooms: 2,
    bathrooms: 2,
    address: '303 Beach Road, Pattaya',
    description: 'Beachfront apartment with gym and swimming pool facilities.'
  },
  {
    property_type: 'condo',
    price: 2100000,
    bedrooms: 2,
    bathrooms: 1,
    address: '404 Walking Street, Pattaya',
    description: 'City center condo with 24/7 security and entertainment nearby.'
  },
  {
    property_type: 'house',
    price: 3200000,
    bedrooms: 3,
    bathrooms: 2,
    address: '505 Kata Beach, Phuket',
    description: 'Traditional Thai house near beautiful Kata Beach.'
  },
  {
    property_type: 'apartment',
    price: 2500000,
    bedrooms: 1,
    bathrooms: 1,
    address: '606 Asok Road, Bangkok',
    description: 'Studio apartment with modern amenities in business district.'
  },
  {
    property_type: 'townhouse',
    price: 4100000,
    bedrooms: 3,
    bathrooms: 2,
    address: '707 Huai Khwang, Bangkok',
    description: 'Family townhouse with private parking in quiet neighborhood.'
  },
  {
    property_type: 'condo',
    price: 12000000,
    bedrooms: 4,
    bathrooms: 3,
    address: '808 Sathorn Road, Bangkok',
    description: 'Luxury penthouse with river views, gym and infinity pool.'
  },
  {
    property_type: 'apartment',
    price: 1950000,
    bedrooms: 1,
    bathrooms: 1,
    address: '909 Ratchadaphisek Road, Bangkok',
    description: 'Affordable apartment with MRT access and basic amenities.'
  }
]

Property.create!(thailand_properties)

# Additional sample properties for pagination testing
thailand_cities = [ 'Bangkok', 'Phuket', 'Chiang Mai', 'Pattaya', 'Hua Hin', 'Koh Samui', 'Krabi', 'Chiang Rai' ]
thai_roads = [ 'Sukhumvit', 'Silom', 'Sathorn', 'Phetchaburi', 'Ratchadamri', 'Wireless', 'Ploenchit', 'Asok' ]

additional_properties = (1..20).map do |i|
  city = thailand_cities.sample
  road = thai_roads.sample

  {
    property_type: %w[ house apartment condo townhouse ].sample,
    price: rand(1_500_000..15_000_000),
    bedrooms: rand(1..5),
    bathrooms: rand(1..4),
    address: "#{100 + i} #{road} Road, #{city}",
    description: "Beautiful Thai property ##{i} in #{city} with modern amenities and great location."
  }
end

Property.create!(additional_properties)
