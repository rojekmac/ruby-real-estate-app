class PagesController < ApplicationController
  def about
  end

  def contact
  end

  def listings
    Rails.logger.info "FILTER PARAMS: #{params.slice(:type, :price, :bedrooms, :bathrooms).inspect}"
    @properties = Property.all
    @properties = @properties.by_type(params[:type])
    @properties = @properties.by_price(params[:price])
    @properties = @properties.by_bedrooms(params[:bedrooms])
    @properties = @properties.by_bathrooms(params[:bathrooms])
    @properties = @properties.order(created_at: :desc)
    @properties = @properties.page(params[:page]).per(6)
  end
end
