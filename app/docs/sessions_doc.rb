module SessionsDoc
  extend Apipie::DSL::Concern

  api :Post, 'auth/sign_in', 'Create user session'
  error code: 401, desc: 'Unauthorized'
  param :email, String, desc: 'User email', required: true
  param :password, String, desc: 'User password', required: true
  example '
  {
    "data": {
        "id": "1",
        "email": "user@user.com",
        "provider": "email",
        "uid": "user@user.com"
    }
  }'
  def create; end

  api :DELETE, 'auth/sign_out', 'Destroy user session'
  error code: 404, desc: 'User was not found or was not logged in'
  example '
  {
    "success": true
  }'
  def destroy; end

end