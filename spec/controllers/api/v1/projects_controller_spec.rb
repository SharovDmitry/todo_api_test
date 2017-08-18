require "rails_helper"

describe Api::V1::ProjectsController, type: :controller do
  before do
    authenticate_user
  end

  describe "GET 'index'" do
    it "should returns a successful response" do
      get :index, format: :json
      expect(response).to have_http_status(:success)
    end

    it "should returns all projects" do
      FactoryGirl.create_list(:project, 5, user: @user)
      get :index, format: :json
      parsed_response = JSON.parse(response.body)['data']
      expect(parsed_response['projects'].length).to eq(5)
    end
  end

  describe "POST 'create'" do
    context "correct params format" do
      it "should returns a successful json string with success response" do
        post :create, params: { project: { name: 'New Project' } }
        expect(response).to have_http_status(:created)
        parsed_response = JSON.parse(response.body)['data']
        expect(parsed_response['project']['name']).to eq("New Project")
      end

      it "should change project count by 1" do
        expect { post :create, params: { project: { name: 'New Project' } } }.to change { Project.count }.by(1)
      end
    end

    context "incorrect params format" do
      it "should returns an error if blank name is submitted" do
        post :create, params: { project: { name: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response[0]).to eq("Name can't be blank")
      end

      it "should returns an error if too long name is submitted" do
        post :create, params: { project: { name: rand(36**51).to_s(36) } }
        expect(response).to have_http_status(:unprocessable_entity)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response[0]).to eq("Name is too long (maximum is 50 characters)")
      end
    end
  end

  describe "PUT 'update'" do
    before do
      @project = create(:project, user: @user)
    end

    context "correct update params" do
      it "should returns an empty json string with success response" do
        put :update, params: { id: @project, project: { name: 'New Name' } }
        expect(response).to have_http_status(:success)
        expect(response.body).to be_empty
      end
    end

    context "incorrect update params" do
      it "should returns an error if blank name is submitted" do
        put :update, params: { id: @project, project: { name: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response[0]).to eq("Name can't be blank")
      end

      it "should returns an error if too long name is submitted" do
        put :update, params: { id: @project, project: { name: rand(36**51).to_s(36) } }
        expect(response).to have_http_status(:unprocessable_entity)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response[0]).to eq("Name is too long (maximum is 50 characters)")
      end
    end
  end

  describe "DELETE 'destroy'" do
    before do
      @project = create(:project, user: @user)
    end

    it "should delete project and returns an empty json string with success response" do
      delete :destroy, params: { id: @project }
      expect(response).to have_http_status(:success)
      expect(response.body).to be_empty
    end

    it "should change project count by -1" do
      expect { delete :destroy, params: { id: @project } }.to change { Project.count }.by(-1)
    end
  end
end