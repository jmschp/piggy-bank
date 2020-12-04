class Punishment < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :points, presence: true
end
