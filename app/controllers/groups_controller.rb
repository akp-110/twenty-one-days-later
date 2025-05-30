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
    emails = group_params[:user_emails].reject(&:blank?)
    users = User.where(email: emails)
    users.each do |user|
      @group.group_memberships.create(user: user)
    end

    @group.group_memberships.find_or_create_by(user: current_user)

    redirect_to groups_path, notice: "Group created successfully!"
    else
    render :new
    end
  end
end

def show
  @group = Group.find_by(id: params[:id])
  unless @group
    redirect_to groups_path, alert: "Group not found!" and return
  end
end
  private

  def group_params
    params.require(:group).permit(:name, user_emails: [])
  end
end
