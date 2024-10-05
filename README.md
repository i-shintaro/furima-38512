# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| first_name         | string  | null: false               |
| last_name          | string  | null: false               |
| first_name_kana    | string  | null: false               |
| last_name_kana     | string  | null: false               |
| birth_data         | integer | null: false               |


### Association
- has_many :items
- has_many :orders

## items テーブル

| Column              | Type       | Option                         |
| ------------------- | ---------- | ------------------------------ |
| item_name           | string     | null: false                    |
| description         | text       | null: false                    |
| condition_id        | integer    | null: false                    |
| category_id         | integer    | null: false                    |
| shipping_charges_id | integer    | null: false                    |
| shipment_area_id    | integer    | null: false                    |
| shipment_day_id     | integer    | null: false                    |
| user                | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :item



## orders テーブル

| Column | Type       | Option                         |
| ------ | ---------- | ------------------------------ |
| price  | integer    | null: false                    |
| item   | references | null: false, foreign_key: true |
| user   | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :shipping


## shippings テーブル

| Column        | Type       | Option                         |
| ------------- | ---------- | ------------------------------ |
| postal_code   | integer    | null: false                    |
| prefecture    | integer    | null: false                    |
| city          | text       | null: false                    |
| street        | text       | null: false                    |
| building_name | text       | null: false                    |
| phone_number  | integer    | null: false                    |
| order         | references | null: false, foreign_key: true |
