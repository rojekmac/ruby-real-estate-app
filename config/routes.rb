Rails.application.routes.draw do
  root "home#index"

  # Language switching
  get "language/switch/:locale", to: "language#switch", as: :switch_language

  # Home
  get "home/index"

  # Pages
  get "pages/about"
  get "pages/contact"
  get "pages/listings"


  # Users
  get "users/profile"
  get "users/login"

  # Services
  get "services/valuation"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
 end
