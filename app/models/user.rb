class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { maximum: 50 }
  validates :phone, presence: true
  
  has_many :tasks
  has_many :goals
  has_many :punishments
  belongs_to :family, optional: true

  has_one_attached :photo

  accepts_nested_attributes_for :family
end
