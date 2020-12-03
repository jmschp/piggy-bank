TASKS_TYPE = ["Casa", "Escola"]
TASKS_POINTS = [1, 2, 3, 4, 5]
class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 250 }
  validates :points, presence: true, inclusion: { in: TASKS_POINTS }
  validates :task_type, presence: true, inclusion: { in: TASKS_TYPE }
  # validates :finished, presence: true
end
