class GoalsController < ApplicationController
  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.build(goal_params)
    if @goal.save
      redirect_to @goal, notice: "Your goal is set. Now let’s make it happen—one step, one day at a time!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:name, :reason)
  end
end
