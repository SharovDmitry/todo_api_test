module RegistrationsDoc
  extend Apipie::DSL::Concern

  api :POST, 'auth', 'Create new user'
  error code: 422, desc: 'Unprocessable entity'
  param :email, String, desc: 'User email', required: true
  param :password, String, desc: 'User password', required: true
  param :password_confirmation, String, desc: 'Password confirmation', required: true
  example '
  {
    "data": {
        "id": "1",
        "provider": "email",
        "uid": "user@user.com",
        "email": "user@user.com",
        "created_at": "2017-12-31T00:00:00.000Z",
        "updated_at": "2017-12-31T00:00:00.000Z"
    }
  }'
  def create; end

end