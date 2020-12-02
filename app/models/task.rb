TASKS_TYPE = ["Casa", "Escola"]
class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 250 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :points, presence: true, length: { maximum: 10 }
  validates :type, presence: true, inclusion: { in: TASKS_TYPE }
  # validates :finished, presence: true
end
