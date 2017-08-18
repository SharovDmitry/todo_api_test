class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can [:read, :create], [Project, Task, Comment]

    can [:update, :destroy], Project, user_id: user.id

    can [:update, :destroy], Task do |task|
      task.project.user == user
    end

    can [:destroy], Comment do |comment|
      comment.task.project.user == user
    end
  end

end
