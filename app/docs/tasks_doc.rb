module TasksDoc
  extend Apipie::DSL::Concern

  api :GET, 'api/v1/projects/:project_id/tasks', 'Get all project tasks'
  error code: 401, desc: 'Unauthorized'
  example '
  {
    "data": {
        "tasks": [
            {
                "id": "1",
                "name": "First task",
                "completed": true,
                "deadline": "",
                "position": 1
            },
            {
                "id": "2",
                "name": "Second task",
                "completed": false,
                "deadline": "31.12.2017",
                "position": 2
            }
        ]
    }
  }'
  def index; end

  api :POST, 'api/v1/projects/:project_id/tasks', 'Create new task'
  error code: 400, desc: 'Bad request'
  error code: 401, desc: 'Unauthorized'
  error code: 422, desc: 'Unprocessable entity'
  param :name, String, desc: 'Task name', required: true
  example '
  {
    "data": {
        "task": {
            "id": "1",
            "name": "Task Name",
            "completed": false,
            "deadline": "",
            "position": 1
        }
    }
  }'
  def create; end

  api :PUT, 'api/v1/projects/:project_id/tasks/:id', 'Update task'
  error code: 400, desc: 'Bad request'
  error code: 401, desc: 'Unauthorized'
  error code: 422, desc: 'Unprocessable entity'
  param :name, String, desc: 'New task name'
  param :completed, [true, false], desc: 'Task status'
  param :deadline, String, desc: 'Task deadline. Should be in "DD-MM-YYYY" format'
  example ':no_content, status: 200'
  def update; end

  api :DELETE, 'api/v1/projects/:project_id/tasks/:id', 'Delete task'
  error code: 401, desc: 'Unauthorized'
  example ':no_content, status: 200'
  def destroy; end

  api :PUT, 'api/v1/projects/:project_id/sort_tasks', 'Update tasks positions'
  error code: 400, desc: 'Bad request'
  error code: 401, desc: 'Unauthorized'
  error code: 422, desc: 'Unprocessable entity'
  param :order, String, desc: 'New tasks positions. Should be a hash, where key is task id and value is a new position ', required: true
  example ':no_content, status: 200'
  def sort; end

end