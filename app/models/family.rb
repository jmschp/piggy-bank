class Family < ApplicationRecord
  has_many :users

  validates :name, presence: true, length: { maximum: 150 }

  # after_commit :set_family_leader, only: :create

  private

  def set_family_leader
    self.users.first.update(admin: true)
  end
end
