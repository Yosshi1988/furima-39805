class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :shipping_time
  belongs_to :user
  has_one_attached :image

  validates :image, presence: true
  validates :name, presence: true, length: { maximum: 40 }
  validates :content, presence: true, length: { maximum: 1000 }
  validates :category_id, :condition_id, :delivery_charge_id, :prefecture_id, :shipping_time_id,
            numericality: { other_than: 1, message: "can't be blank" }
  validates :price, presence: true, numericality: { in: 300..9_999_999 }
end
