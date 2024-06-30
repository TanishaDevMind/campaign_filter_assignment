require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user1) { User.create(name: "Alice", email: "alice@example.com", campaigns_list: [{"campaign_name" => "cam4", "campaign_id" => "id4"}]) }
  let!(:user2) { User.create(name: "Bob", email: "bob@example.com", campaigns_list: [{"campaign_name" => "cam5", "campaign_id" => "id5"}]) }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_attributes) do
        {
          user: {
            name: "Charlie",
            email: "charlie@example.com",
            campaigns_list: [
              { campaign_name: "cam6", campaign_id: "id6" }
            ]
          }
        }
      end

      it "creates a new User" do
        expect {
          post :create, params: valid_attributes
        }.to change(User, :count).by(1)
      end

      it "returns a created status" do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) do
        {
          user: {
            name: "",
            email: "invalid",
            campaigns_list: []
          }
        }
      end

      it "does not create a new User" do
        expect {
          post :create, params: invalid_attributes
        }.to change(User, :count).by(0)
      end

      it "returns an unprocessable entity status" do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET #filter" do
    it "returns users matching the campaign names" do
      get :filter, params: { campaign_names: "cam4,cam6" }
      expect(response).to be_successful
      users = JSON.parse(response.body)
      expect(users.size).to eq(1)
      expect(users.first["name"]).to eq("Alice")
    end

    it "returns all users if no campaign names are provided" do
      get :filter, params: { campaign_names: "" }
      expect(response).to be_successful
      users = JSON.parse(response.body)
      expect(users.size).to eq(2)
    end

    it "returns all users if no matching campaign names are found" do
        get :filter, params: { campaign_names: "cam6" }
        expect(response).to be_successful
        users = JSON.parse(response.body)
        expect(users.size).to eq(2)
      end
  end
end
