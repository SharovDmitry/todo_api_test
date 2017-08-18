class Api::V1::CommentsController < Api::V1::BaseController
  include CommentsDoc

  before_action :find_task
  before_action :find_comment, only: :destroy

  def index
    @comment = @task.comments.all
    render :index, status: :ok
  end

  def create
    @comment = @task.comments.create(comment_params)
    if @comment.persisted?
      render :create, status: :created
    else
      render json: @comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    head(:ok)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :image)
  end

  def find_task
    project = current_user.projects.find(params[:project_id])
    @task = project.tasks.find(params[:task_id])
  end

  def find_comment
    @comment = @task.comments.find(params[:id])
  end
end