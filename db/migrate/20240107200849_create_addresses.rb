class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :postal_code, null: false
      t.integer :prefecture_id, null: false
      t.string :city, null:false
      t.string :street_address, null: false
      t.string :building
      t.string :tel, null: false
      t.references :purchase, null: false, foreign_key: true
      t.timestamps
    end
  end
end
