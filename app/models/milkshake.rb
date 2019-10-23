class Milkshake < ApplicationRecord
    has_many :ingredients_milkshakes
    has_many :ingredients, through: :ingredients_milkshakes
    # has_one :image, as: :imageable
    validates :name, :price, presence: true 
    validates :price, numericality: { greater_than: 10}
    has_one_attached :pic
    belongs_to :user
end
