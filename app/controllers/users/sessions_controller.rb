class Users::SessionsController < DeviseTokenAuth::SessionsController
  include SessionsDoc
end