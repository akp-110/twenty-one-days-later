class GoalsController < ApplicationController
  before_action :authenticate_user!

  def new
    @group = current_user.groups.find(params[:group_id])
    @goal = @group.goals.build
  end

  def index
    @group = current_user.groups.first
    @goals = @group.goals if @group.present?
  end

  def create

    @group = current_user.groups.find_by(id: params[:group_id])
     if @group.nil?
      redirect_to groups_path, alert: "Invalid group" and return
     end

      @goal = @group.goals.build(goal_params.merge(user: current_user))


    if @goal.save
      redirect_to group_goal_path(@group, @goal), notice: "Your goal is set."
    else
      flash[:alert] = "Something went wrong. Please try again."
      redirect_to new_group_goal_path(@group)

    end
  end

  def show
      @goal = Goal.find_by(id: params[:id])
    unless @goal
      redirect_to goals_path, alert: "Goal not found!" and return
    end
  end

  def edit
    @group = current_user.groups.find_by(id: params[:group_id])
    redirect_to groups_path, alert: "Group not found!" unless @group

    @goal = @group.goals.find_by(id: params[:id])
    redirect_to group_goals_path(@group), alert: "Goal not found!" unless @goal
  end

  def update
    @group = current_user.groups.find_by(id: params[:group_id])
    @goal = @group.goals.find_by(id: params[:id])

   if @goal.update(goal_params)
    redirect_to group_goal_path(@group, @goal), notice: "Goal updated!"
   else
    flash[:alert] = "Something went wrong. Please try again."
    render :edit
   end
  end

   def destroy
    @group = current_user.groups.find(params[:group_id])
    @goal = @group.goals.find(params[:id])

    @goal.destroy
    redirect_to group_goals_path(@group), notice: "Goal deleted."
   end

  private

  def goal_params
    params.require(:goal).permit(:name, :reason)
  end
end
