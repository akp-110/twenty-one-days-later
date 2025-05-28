class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = current_user.joined_groups
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.build(group_params)
    if @group.save
      # Add creator as a group member with 'admin' role
      GroupMembership.create(user: current_user, group: @group)
      redirect_to groups_path, notice: "Group created successfully!"
    else
      render :new, alert: "Something went wrong."
    end
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
