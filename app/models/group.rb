class Group < ApplicationRecord
  belongs_to :user
  has_many :group_memberships, dependent: :destroy
  has_many :members, through: :group_memberships, source: :user

  has_many :goals, dependent: :destroy

  validates :name, presence: true


end
