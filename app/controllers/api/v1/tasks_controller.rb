class Api::V1::TasksController < Api::V1::BaseController
  include TasksDoc

  before_action :find_project
  before_action :find_task, only: [:update, :destroy, :complete]

  def index
    @tasks = @project.tasks.all.order(:position)
    render :index, status: :ok
  end

  def create
    @task = @project.tasks.create(task_params)
    if @task.persisted?
      @project.update_task_positions
      render :create, status: :created
    else
      render json: @task.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    task_updated = @task.update(task_params)
    if task_updated
      head(:ok)
    else
      render json: @task.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    head(:ok)
  end

  def sort
    if params[:order].present?
      @project.sort_tasks(params[:order])
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :completed, :deadline)
  end

  def find_project
    @project = current_user.projects.find(params[:project_id])
  end

  def find_task
    @task = @project.tasks.find(params[:id])
  end
end