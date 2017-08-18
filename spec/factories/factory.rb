FactoryGirl.define do

  factory :user do
    email { FFaker::Internet.email }
    password 'P@ssw0rd'
    provider 'email'
    uid { email }
  end

  factory :project do
    user
    name 'Project name'
  end

  factory :task do
    project
    name 'Task name'
  end

  factory :comment do
    task
    content 'Task name'
  end

end