module ProjectsDoc
  extend Apipie::DSL::Concern

  api :GET, 'api/v1/projects', 'Get all user projects'
  error code: 401, desc: 'Unauthorized'
  example '
  {
    "data": {
        "projects": [
            {
                "id": "1",
                "name": "Home"
            },
            {
                "id": "2",
                "name": "Work"
            }
        ]
    }
  }'
  def index; end

  api :POST, 'api/v1/projects', 'Create new project'
  error code: 400, desc: 'Bad request'
  error code: 401, desc: 'Unauthorized'
  error code: 422, desc: 'Unprocessable entity'
  param :name, String, desc: 'Project name', required: true
  example '
  {
    "data": {
        "project": {
            "id": "1",
            "name": "Project Name"
        }
    }
  }'
  def create; end

  api :PUT, 'api/v1/projects/:id', 'Update project'
  error code: 400, desc: 'Bad request'
  error code: 401, desc: 'Unauthorized'
  error code: 422, desc: 'Unprocessable entity'
  param :name, String, desc: 'Project name', required: true
  example ':no_content, status: 200'
  def update; end

  api :DELETE, 'api/v1/projects/:id', 'Delete project'
  error code: 401, desc: 'Unauthorized'
  example ':no_content, status: 200'
  def destroy; end

end