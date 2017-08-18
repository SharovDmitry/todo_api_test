class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :projects, dependent: :destroy
  has_many :tasks, through: :projects
end
