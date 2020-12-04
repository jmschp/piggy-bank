class Goal < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 250 }
end
