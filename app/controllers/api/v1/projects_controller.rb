class Api::V1::ProjectsController < Api::V1::BaseController
  include ProjectsDoc

  before_action :find_project, only: [:update, :destroy]

  def index
    @projects = current_user.projects.all.reverse
    render :index, status: :ok
  end

  def create
    @project = current_user.projects.create(project_params)
    if @project.persisted?
      render :create, status: :created
    else
      render json: @project.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    project_updated = @project.update(project_params)
    if project_updated
      head(:ok)
    else
      render json: @project.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    head(:ok)
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end

  def find_project
    @project = current_user.projects.find(params[:id])
  end
end