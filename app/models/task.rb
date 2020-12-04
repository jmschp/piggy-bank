TASKS_POINTS = [1, 2, 3, 4, 5]
# task_type - True --> Casa | False --> Escola
class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 250 }
  validates :points, presence: true, inclusion: { in: TASKS_POINTS }
  validates :home, inclusion: { in: [true, false] }
end
