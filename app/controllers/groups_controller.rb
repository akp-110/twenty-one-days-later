class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
  #@groups = current_user.joined_groups
  @groups = Group.all

  end

  def new
    @group = Group.new
  end

  def create
  @group = Group.new(name: group_params[:name])
  if @group.save
    # Add selected members
    emails = group_params[:user_emails].reject(&:blank?)
    users = User.where(email: emails)
    users.each { |user| @group.members << user }

    # Add the current user as a member (if not already handled automatically)
    @group.members << current_user unless @group.members.include?(current_user)

    # Redirect to the My Groups page (usually groups index)
    redirect_to groups_path, notice: "Group created successfully!"
  else
    render :new
  end
end



  private

  def group_params
    params.require(:group).permit(:name, user_emails: [])
  end
end
