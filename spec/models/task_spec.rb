require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    @user = build(:user)
    @project = build(:project, user: @user)
  end

  it 'is valid with valid attributes' do
    expect(@project.tasks.new(name: 'New Task', deadline: '31.12.2017')).to be_valid
  end

  it 'is not valid without a name' do
    task = @project.tasks.new(name: nil)
    expect(task).to_not be_valid
  end

  it 'is not valid without project' do
    task = Task.new(name: 'New Task')
    expect(task).to_not be_valid
  end

  it 'is not valid with with very long name' do
    task = @project.tasks.new(name: rand(36**51).to_s(36))
    expect(task).to_not be_valid
  end

  it 'is not valid with wrong deadline' do
    task = @project.tasks.new(name: 'New Task', deadline: 'deadline')
    expect(task).to_not be_valid
  end
end