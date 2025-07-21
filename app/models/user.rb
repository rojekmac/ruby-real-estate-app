class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable, :trackable

  # Admin role functionality
  def admin?
    admin
  end

  def make_admin!
    update!(admin: true)
  end
end
