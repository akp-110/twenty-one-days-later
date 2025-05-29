class GroupMembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group

  def create
    if @group.members.include?(current_user)
      redirect_to groups_path, alert: "You're already a member of this group."
    else
      membership = GroupMembership.new(user: current_user, group: @group)
      if membership.save
        redirect_to groups_path, notice: "You successfully joined the group!"
      else
        redirect_to groups_path, alert: "Could not join the group."
      end
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end
end
