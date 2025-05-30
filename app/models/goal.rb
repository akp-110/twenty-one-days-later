class Goal < ApplicationRecord
  belongs_to :user
  belongs_to :group
  validates :name, presence: true
  validates :reason, presence: true
validates :start_date, presence: true


  #  def index
  #   @goals = Goal.all
  # end

  # def show
  #   @goal = Goal.find(params[:id])
  # end

end
