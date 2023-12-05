# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string  | null: false |
| email              | string  | null: false |
| encrypted_password | string  | null: false |
| last_name          | string  | null: false |
| first_name         | string  | null: false |
| kana_last_name     | string  | null: false |
| kana_first_name    | string  | null: false |
| birth_year         | integer | null: false |
| birth_month        | integer | null: false |
| birth_day          | integer | null: false |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column          | type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| image           | text       | null: false                    |
| name            | string     | null: false                    |
| content         | text       | null: false                    |
| category        | string     | null: false                    |
| condition       | string     | null: false                    |
| delivery_charge | string     | null: false                    |
| shipping_origin | string     | null: false                    |
| shipping_time   | string     | null: false                    |
| price           | integer    | null: false                    |
| user            | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase

## purchases テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| postal_code    | string     | null: false                    |
| prefectures    | string     | null: false                    |
| city           | string     | null: false                    |
| street_address | string     | null: false                    |
| building       | string     |                                |
| user           | references | null: false, foreign_key: true |
| item           | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
