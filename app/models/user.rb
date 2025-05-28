class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :group_memberships
  has_many :joined_groups, through: :group_memberships, source: :group

  has_many :groups
  has_many :goals
end
