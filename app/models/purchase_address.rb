class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_code, :prefecture_id, :city, :street_address, :building, :tel, :token

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'はハイフン(-)を含む半角数字で入力してください' }
    validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }
    validates :city
    validates :street_address
    validates :tel,
              format: { with: /\A[0-9]{10,11}\z/, message: 'は10桁または11桁の半角数字で入力してください' }
    validates :token
  end

  def save
    purchase = Purchase.create(item_id:, user_id:)
    Address.create(postal_code:, prefecture_id:, city:, street_address:,
                   building:, tel:, purchase_id: purchase.id)
  end
end
