class CreateShippings < ActiveRecord::Migration[7.0]
  def change
    create_table :shippings do |t|
      t.string  :postal_code,   null: false
      t.integer :prefecture_id, null: false
      t.text    :city,          null: false
      t.text    :street,        null: false
      t.string  :building_name, null: false
      t.string  :phone_number,  null: false
      t.references :order,      null: false, foreign_key: true
      t.timestamps
    end
  end
end
