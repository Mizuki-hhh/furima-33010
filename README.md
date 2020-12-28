# テーブル設計

## users テーブル

| Column              | Type   | Options                   |
| ------------------- |------- | ------------------------- |
| email               | string | null: false, unique: true |
| encrypted_password  | string | null: false               |
| nickname            | string | null: false               |
| last_name           | string | null: false               |
| first_name          | string | null: false               |
| furigana_last_name  | string | null: false               |
| furigana_first_name | string | null: false               |
| birthday            | date   | null: false               |

### Association

- has_many :items
- has_many :records

- has_many :comments

## items テーブル

| Column             | Type       | Options                        |
| ------------------ |----------- | ------------------------------ |
| name               | string     | null: false                    |
| explanation        | text       | null: false                    |
| category_id        | integer    | null: false                    |
| condition_id       | integer    | null: false                    |
| shipping_charge_id | integer    | null: false                    |
| prefecture_id      | integer    | null: false                    |
| shipping_date_id   | integer    | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :record

- has_many :item_tag_relations
- has_many :tags, through: :item_tag_relations
- has_many :comments

## records テーブル

| Column | Type       | Options                        |
| ------ |----------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル

| Column        | Type       | Options                        |
| ------------- |----------- | ------------------------------ |
| postal_code   | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| house_number  | string     | null: false                    |
| building_name | string     |                                |
| phone_number  | string     | null: false                    |
| record        | references | null: false, foreign_key: true |

### Association

- belongs_to :record


* 追加実装

# tags テーブル

| Column   | Type   | Options                       |
| -------- |------- | ----------------------------- |
| tag_name | string | null: false, uniqueness: true |

### Association

- has_many :item_tag_relations
- has_many :items, through: :item_tag_relations

# item_tag_relations テーブル

| Column | Type       | Options                        |
| ------ |----------- | ------------------------------ |
| item   | references | null: false, foreign_key: true |
| tag    | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :tag

# comments テーブル

| Column | Type       | Options                        |
| ------ |----------- | ------------------------------ |
| text   | text       | null: false                    |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
