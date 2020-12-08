class Goal < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 250 }
  validates :total_points, presence: true

  after_commit :finish_goal, only: :update

  private

  def finish_goal
    self.update_columns(finished: true) if self.points == self.total_points
  end
end
