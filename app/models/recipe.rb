class Recipe < ApplicationRecord
  has_many :steps, dependent: :destroy
  has_many :ingredients, dependent: :destroy
  
  belongs_to :image, dependent: :destroy, optional: true

  accepts_nested_attributes_for :steps
  accepts_nested_attributes_for :ingredients

  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 512 }
end
