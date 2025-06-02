class GoalCompletionsController < ApplicationController

  before_action :set_group

  def update_progress
    day = params[:day].to_i
    completed = ActiveModel::Type::Boolean.new.cast(params[:completed])
    user = current_user

    goal = @group.goals.first

    if completed
      GoalCompletion.find_or_create_by(user: user, goal: goal, date: goal.start_date + day.days)
    else
      GoalCompletion.where(user: user, goal: goal, date: goal.start_date + day.days).destroy_all
    end

    render json: { success: true }
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end
end
