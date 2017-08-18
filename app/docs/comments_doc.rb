module CommentsDoc
  extend Apipie::DSL::Concern

  api :GET, 'api/v1/projects/:project_id/tasks/:task_id/comments', 'Get all task comments'
  error code: 401, desc: 'Unauthorized'
  example '
  {
    "data": {
        "comments": [
            {
                "id": "1",
                "content": "Comment text...",
                "file_url": "path/for/image"
            },
            {
                "id": "2",
                "content": "Comment text...",
                "file_url": null
            }
        ]
    }
  }'
  def index; end

  api :POST, 'api/v1/projects/:project_id/tasks/:task_id/comments', 'Create new comment'
  error code: 400, desc: 'Bad request'
  error code: 401, desc: 'Unauthorized'
  error code: 422, desc: 'Unprocessable entity'
  param :content, String, desc: 'Comment content', required: true
  param :image, ['Base64'], desc: 'Comment image'
  example '
  {
    "data": {
        "comment": {
            "id": "1",
            "name": "Comment text...",
            "file_url": "path/for/image"
        }
    }
  }'
  def create; end

  api :DELETE, 'api/v1/projects/:project_id/tasks/:task_id/comments/:id', 'Delete comment'
  error code: 401, desc: 'Unauthorized'
  example ':no_content, status: 200'
  def destroy; end

end