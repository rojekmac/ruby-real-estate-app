class Property < ApplicationRecord
  validates :address, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :bedrooms, presence: true, numericality: { greater_than: 0 }
  validates :bathrooms, presence: true, numericality: { greater_than: 0 }
  validates :property_type, inclusion: { in: %w[house apartment condo townhouse] }
  validates :description, presence: true

  # Serialize images as JSON array
  serialize :images, JSON

  # Helper method to get the primary image for listings
  def primary_image
    return 'propertyPhoto.jpg' if images.blank? || images.empty?
    
    images.first
  end

  # Helper method to get all images or fallback to default
  def all_images
    return [ 'propertyPhoto.jpg' ] if images.blank? || images.empty?
    
    images
  end
  scope :by_type, ->(type) {
    type.present? && %w[house apartment condo townhouse].include?(type) ? where(property_type: type) : all
  }
  scope :by_price, ->(price) {
    if price.present?
      if price.to_s.ends_with?("+") && price.to_s.to_i > 0
        where("price >= ?", price.to_s.to_i)
      elsif price.to_s =~ /\A\d+-\d+\z/
        min, max = price.split("-").map(&:to_i)
        where(price: min..max)
      else
        all
      end
    else
      all
    end
  }
  scope :by_bedrooms, ->(bedrooms) {
    n = bedrooms.to_i
    bedrooms.present? && n > 0 ? where("bedrooms >= ?", n) : all
  }
  scope :by_bathrooms, ->(bathrooms) {
    n = bathrooms.to_i
    bathrooms.present? && n > 0 ? where("bathrooms >= ?", n) : all
  }
end
