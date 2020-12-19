# テーブル設計

## users テーブル

| Column              | Type    | Options                   |
| ------------------- |-------- | ------------------------- |
| email               | string  | null: false, unique: true |
| password            | string  | null: false               |
| nickname            | string  | null: false               |
| last_name           | string  | null: false               |
| first_name          | string  | null: false               |
| furigana_last_name  | string  | null: false               |
| furigana_first_name | string  | null: false               |
| birth_year_id       | integer | null: false               |
| birth_month_id      | integer | null: false               |
| birth_day_id        | integer | null: false               |

### Association

- has_many :items
- has_many :records

## items テーブル

| Column             | Type       | Options                        |
| ------------------ |----------- | ------------------------------ |
| item_name          | string     | null: false                    |
| explanation        | text       | null: false                    |
| category_id        | integer    | null: false                    |
| condition_id       | integer    | null: false                    |
| shipping_charge_id | integer    | null: false                    |
| area_id            | integer    | null: false                    |
| shipping_date_id   | integer    | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :record

## records テーブル

| Column    | Type       | Options                        |
| --------- |----------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| item_name | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- belongs_to :address

## addresses テーブル

| Column        | Type    | Options     |
| ------------- |-------- | ----------- |
| postal_code   | string  | null: false |
| prefecture_id | integer | null: false |
| city          | string  | null: false |
| house_number  | string  | null: false |
| building_name | string  |             |
| phone_number  | integer | null: false |

### Association

- has_many :records