class User < ApplicationRecord
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze # rubocop:disable Style/RedundantFreeze
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, :last_name, :first_name, :kana_last_name, :kana_first_name, :birth_date, presence: true
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には半角英字と半角数字の両方を含めて設定してください'
  validates_format_of :last_name, :first_name, with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'には全角かな/カナ漢字のみ使用できます'
  validates_format_of :kana_last_name, :kana_first_name, with: /\A[ァ-ヶー]+\z/, message: 'には全角カナのみ使用できます'
end
