class Family < ApplicationRecord
  has_many :users
  has_one :chatroom

  validates :name, presence: true, length: { maximum: 150 }

  # after_commit :set_family_leader, only: :create
  after_commit :create_family_chatroom, only: :create

  private

  def set_family_leader
    self.users.first.update(admin: true)
  end

  def create_family_chatroom
    Chatroom.create(name: "Sala da Família #{self.name}", family_id: self.id)
  end
end
