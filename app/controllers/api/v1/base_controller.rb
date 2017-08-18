class Api::V1::BaseController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
end