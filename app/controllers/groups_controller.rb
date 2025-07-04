class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = current_user.joined_groups
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(name: group_params[:name], user: current_user)
    if @group.save
      usernames = Array(group_params[:user_usernames]).reject(&:blank?)
      users = User.where(username: usernames)
      users.each do |user|
        @group.group_memberships.create(user: user)
      end

      @group.group_memberships.find_or_create_by(user: current_user)

      redirect_to groups_path, notice: "Group created successfully!"
    else
      render :new
    end
  end


  def show
    @group = Group.find_by(id: params[:id])

    @comment = Comment.new
    @comments = @group.comments

      @completed_dates = GoalCompletion
    .where(goal: @goal)
    .group_by(&:user_id)
    .transform_values { |completions| completions.map(&:date) }

    @goal = @group.goals.first # ✅ Load the first goal for the countdown

    unless @group
      redirect_to groups_path, alert: "Group not found!" and return
    end
  end

    def destroy
      @group = current_user.groups.find(params[:id])

      @group.destroy
      redirect_to groups_path, notice: "Group deleted."
    end

  private

  def group_params
    params.require(:group).permit(:name, user_usernames: [])
  end
end
