class Goal < ApplicationRecord
  belongs_to :user
  belongs_to :group



   def index
    @goals = Goal.all
  end

  def show
    @goal = Goal.find(params[:id])
  end


end
