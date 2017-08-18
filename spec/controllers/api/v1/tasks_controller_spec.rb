require "rails_helper"

describe Api::V1::TasksController, type: :controller do
  before do
    authenticate_user
    @project = create(:project, user: @user)
  end

  describe "GET 'index'" do
    it "should returns a successful response" do
      get :index, params: { project_id: @project }, format: :json
      expect(response).to have_http_status(:success)
    end

    it "should returns all tasks" do
      FactoryGirl.create_list(:task, 5, project: @project)
      get :index, params: { project_id: @project }, format: :json
      parsed_response = JSON.parse(response.body)['data']
      expect(parsed_response['tasks'].length).to eq(5)
    end
  end

  describe "POST 'create'" do
    context "correct params format" do
      it "should returns a successful json string with success response" do
        post :create, params: { project_id: @project, task: { name: 'New Task' } }
        expect(response).to have_http_status(:created)
        parsed_response = JSON.parse(response.body)['data']
        expect(parsed_response['task']['name']).to eq("New Task")
        expect(parsed_response['task']['completed']).to eq(false)
        expect(parsed_response['task']['deadline']).to eq('')
        expect(parsed_response['task']['position']).to eq(1)
      end

      it "should change task count by 1" do
        expect { post :create, params: { project_id: @project, task: { name: 'New Task' } } }.to change { Task.count }.by(1)
      end

      it "should update task positions" do
        post :create, params: { project_id: @project, task: { name: 'First Task' } }
        expect(Task.find_by_name('First Task').position).to eq(1)
        post :create, params: { project_id: @project, task: { name: 'Second Task' } }
        expect(Task.find_by_name('Second Task').position).to eq(1)
        expect(Task.find_by_name('First Task').position).to eq(2)
      end
    end

    context "incorrect params format" do
      it "should returns an error if blank name is submitted" do
        post :create, params: { project_id: @project, task: { name: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response[0]).to eq("Name can't be blank")
      end

      it "should returns an error if too long name is submitted" do
        post :create, params: { project_id: @project, task: { name: rand(36**51).to_s(36) } }
        expect(response).to have_http_status(:unprocessable_entity)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response[0]).to eq("Name is too long (maximum is 50 characters)")
      end
    end
  end

  describe "PUT 'update'" do
    before do
      @task = create(:task, project: @project)
    end

    context "correct update params" do
      it "should returns an empty json string with success response on name update" do
        put :update, params: { project_id: @project, id: @task, task: { name: 'New Name' } }
        expect(response).to have_http_status(:success)
        expect(response.body).to be_empty
      end

      it "should returns an empty json string with success response on deadline update" do
        put :update, params: { project_id: @project, id: @task, task: { deadline: '31.12.2017' } }
        expect(response).to have_http_status(:success)
        expect(response.body).to be_empty
        expect(Task.find(@task.id).deadline).to eq("31.12.2017")
      end

      it "should returns an empty json string with success response on complete update" do
        put :update, params: { project_id: @project, id: @task, task: { completed: true } }
        expect(response).to have_http_status(:success)
        expect(response.body).to be_empty
        expect(Task.find(@task.id).completed).to eq(true)
      end
    end

    context "incorrect update params" do
      it "should returns an error if blank name is submitted" do
        put :update, params: { project_id: @project, id: @task, task: { name: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response[0]).to eq("Name can't be blank")
      end

      it "should returns an error if too long name is submitted" do
        put :update, params: { project_id: @project, id: @task, task: { name: rand(36**51).to_s(36) } }
        expect(response).to have_http_status(:unprocessable_entity)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response[0]).to eq("Name is too long (maximum is 50 characters)")
      end

      it "should returns an error if incorrect deadline is submitted" do
        put :update, params: { project_id: @project, id: @task, task: { deadline: 'deadline' } }
        expect(response).to have_http_status(:unprocessable_entity)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response[0]).to eq("Deadline Invalid format")
      end
    end
  end

  describe "DELETE 'destroy'" do
    before do
      @task = create(:task, project: @project)
    end

    it "should delete task and returns an empty json string with success response" do
      delete :destroy, params: { project_id: @project, id: @task.id }
      expect(response).to have_http_status(:success)
      expect(response.body).to be_empty
    end

    it "should change task count by -1" do
      expect { delete :destroy, params: { project_id: @project, id: @task } }.to change { Task.count }.by(-1)
    end
  end
end