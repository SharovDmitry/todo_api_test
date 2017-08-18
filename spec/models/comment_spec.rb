require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @user = build(:user)
    @project = build(:project, user: @user)
    @task = build(:task, project: @project)
  end

  it 'is valid with valid attributes' do
    expect(@task.comments.new(content: 'New Comment',
                              image: 'data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==')).to be_valid
  end

  it 'is valid without a content' do
    comment = @task.comments.new(content: nil, image: 'data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==')
    expect(comment).to be_valid
  end

  it 'is valid without image' do
    comment = @task.comments.new(content: 'New Comment', image: nil)
    expect(comment).to be_valid
  end

  it 'is not valid without project' do
    comment = Comment.new(content: 'New Comment')
    expect(comment).to_not be_valid
  end

  it 'is not valid with very long content' do
    comment = @task.comments.new(content: rand(36**257).to_s(36))
    expect(comment).to_not be_valid
  end

  it 'is not valid without content and image' do
    comment = @task.comments.new(content: nil, image: nil)
    expect(comment).to_not be_valid
  end
end