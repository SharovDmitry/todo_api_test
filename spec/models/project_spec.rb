require 'rails_helper'

RSpec.describe Project, type: :model do
  before do
    @user = build(:user)
  end

  it 'is valid with valid attributes' do
    expect(@user.projects.new(name: 'New Project')).to be_valid
  end

  it 'is not valid without a name' do
    project = @user.projects.new(name: nil)
    expect(project).to_not be_valid
  end

  it 'is not valid without user' do
    project = Project.new(name: 'New Project')
    expect(project).to_not be_valid
  end

  it 'is not valid with with very long name' do
    project = @user.projects.new(name: rand(36**51).to_s(36))
    expect(project).to_not be_valid
  end
end