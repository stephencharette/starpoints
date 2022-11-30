class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :role

  has_many :credit_cards
  has_many :transactions, through: :credit_cards

  after_create :generate_role

  delegate :admin, to: :role

  def generate_role
    Role.create(user: self)
  end
end
