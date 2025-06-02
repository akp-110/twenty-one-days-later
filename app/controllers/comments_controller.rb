class CommentsController < ApplicationController

  def create
    @group = Group.find_by(id: params[:group_id])
    @comment = Comment.new(comment_params)
    @comment.group = @group
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to group_path(@group) }
        format.json # Follows the classic Rails flow and look for a create.json view
      else
        format.html { render "groups/show", status: :unprocessable_entity }
        format.json # Follows the classic Rails flow and look for a create.json view
      end
    end

  end

  def destroy
    @comment = Comment.find(params[:id])
    @group = @comment.group
    @comment.destroy
    redirect_to group_path(@group), notice: "comment deleted."

  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(likes: @comment.likes + 1)
    redirect_to group_path(@comment.group)
  end



  private

  def comment_params
    params.require(:comment).permit(:message)
  end

end
