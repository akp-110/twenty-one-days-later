class Goal < ApplicationRecord
  belongs_to :user
  belongs_to :group
  validates :name, presence: true
  validates :reason, presence: true
  validates :start_date, presence: true

 before_create :set_default_end_date

  private

  def set_default_end_date
    self.end_date ||= self.start_date + 21.days
  end


  #  def index
  #   @goals = Goal.all
  # end

  # def show
  #   @goal = Goal.find(params[:id])
  # end

end
