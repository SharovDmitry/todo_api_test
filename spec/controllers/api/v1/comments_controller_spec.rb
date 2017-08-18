require "rails_helper"

describe Api::V1::CommentsController, type: :controller do
  before do
    authenticate_user
    @project = create(:project, user: @user)
    @task = create(:task, project: @project)
  end

  describe "GET 'index'" do
    it "should returns a successful response" do
      get :index, params: { project_id: @project, task_id: @task, id: @comment }, format: :json
      expect(response).to have_http_status(:success)
    end

    it "should returns all comments" do
      FactoryGirl.create_list(:comment, 5, task: @task)
      get :index, params: { project_id: @project, task_id: @task, id: @comment }, format: :json
      parsed_response = JSON.parse(response.body)['data']
      expect(parsed_response['comments'].length).to eq(5)
    end
  end

  describe "POST 'create'" do
    context "correct params format" do
      it "should returns a successful json string with success response" do
        post :create, params: { project_id: @project, task_id: @task,
                                comment: { content: 'New Comment',
                                           image: 'data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==' } }
        expect(response).to have_http_status(:created)
        parsed_response = JSON.parse(response.body)['data']
        expect(parsed_response['comment']['content']).to eq("New Comment")
        expect(Comment.find(parsed_response['comment']['id']).image.file).not_to be_nil
      end

      it "should create comment with empty image" do
        post :create, params: { project_id: @project, task_id: @task, comment: { content: 'New Comment' } }
        expect(response).to have_http_status(:created)
        parsed_response = JSON.parse(response.body)['data']
        expect(parsed_response['comment']['content']).to eq("New Comment")
        expect(Comment.find(parsed_response['comment']['id']).image.file).to be_nil
      end

      it "should create comment with empty content" do
        post :create, params: { project_id: @project, task_id: @task,
                                comment: { image: 'data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==' } }
        expect(response).to have_http_status(:created)
        parsed_response = JSON.parse(response.body)['data']
        expect(parsed_response['comment']['content']).to be_nil
        expect(Comment.find(parsed_response['comment']['id']).image.file).not_to be_nil
      end

      it "should change comments count by 1" do
        expect { post :create, params: { project_id: @project,
                                         task_id: @task,
                                         comment: { content: 'New Comment' } } }.to change { Comment.count }.by(1)
      end
    end

    context "incorrect params format" do
      it "should returns an error if blank content and image is submitted" do
        post :create, params: { project_id: @project, task_id: @task, comment: { content: nil, image: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response[0]).to eq("Content or Image should be present")
      end

      it "should returns an error if too long name is submitted" do
        post :create, params: { project_id: @project, task_id: @task, comment: { content: rand(36**257).to_s(36), image: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response[0]).to eq("Content is too long (maximum is 256 characters)")
      end
    end
  end

  describe "DELETE 'destroy'" do
    before do
      @comment = create(:comment, task: @task)
    end

    it "should delete comment and returns an empty json string with success response" do
      delete :destroy, params: { project_id: @project, task_id: @task, id: @comment }
      expect(response).to have_http_status(:success)
      expect(response.body).to be_empty
    end

    it "should change comment count by -1" do
      expect { delete :destroy, params: { project_id: @project, task_id: @task, id: @comment } }.to change { Comment.count }.by(-1)
    end
  end
end