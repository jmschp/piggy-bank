class Goal < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 250 }
  validates :total_points, presence: true

  after_commit :finish_goal?, only: :update

  def finish_goal
    if self.points == self.total_points
      self.update(finished: true)
    end
  end
end
