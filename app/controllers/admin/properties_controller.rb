class Admin::PropertiesController < Admin::BaseController
  before_action :set_property, only: [ :show, :edit, :update, :destroy ]

  def index
    @properties = Property.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
  end

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params)

    if @property.save
      redirect_to admin_property_path(@property), notice: "Property was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @property.update(property_params)
      redirect_to admin_property_path(@property), notice: "Property was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @property.destroy
    redirect_to admin_properties_path, notice: "Property was successfully deleted."
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def property_params
    params.require(:property).permit(:property_type, :price, :bedrooms, :bathrooms, :address, :description)
  end
end
