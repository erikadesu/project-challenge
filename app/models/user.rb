class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :dogs, foreign_key: :owner_id
  has_many :likes, dependent: :destroy

  def likes?(dog)
    dog.likes.where(user_id: id).any?
  end

  def owner?(dog)
    dog.owner == self
  end
end
