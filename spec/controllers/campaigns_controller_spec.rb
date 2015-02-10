require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do
  let(:campaign) { create(:campaign) }
  let(:campaign_1) { create(:campaign) }
  let(:user) { create(:user) }
  describe "#new" do
    context "with user logged in" do
      before {
        login(user)
        get :new
      }
      it "assigns a new campaign instance variable" do
        # assigns(:campaign) refers to @campaign
        expect(assigns(:campaign)).to be_a_new(Campaign)
      end
      it "renders the new template" do
        expect(response).to render_template(:new)
      end
    end
    context "with user not logged in" do
      it "redirects to login page" do
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe "#create" do

    context "valid request" do

      def valid_request
        post :create, {
          campaign: {
            title: "Heyy Durr",
            description: "Loren ipsum heroku starbucks",
            goal: 11,
            due_date: "2019-11-11 10:33:20"
            }
          }  
      end

      it "creates a new campaign record in the database" do
        expect { valid_request }.to change { Campaign.count }.by(1)
      end

      it "redirects to campaign show page" do
        valid_request
        expect(response).to redirect_to(campaign_path(Campaign.last))
      end

      it "sets flash message" do
        valid_request
        expect(flash[:notice]).not_to be
      end

    end

    context "invalid request" do

      def invalid_request
        post :create, {
          campaign: {
            title: nil,
            description: "Loren ipsum heroku starbucks",
            goal: 5,
            due_date: "2019-11-11 10:33:20"
            }
          }   
      end

      it "doesn't create a record in the database" do
        expect { invalid_request }.not_to change { Campaign.count }
      end

      it "sets a flash errors message" do
        invalid_request
        expect(flash[:notice]).to be
      end

      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end

    end

  end

  describe "#show" do

    it "assigns a campaign instance with passed id" do
      get :show, id: campaign.id
      expect(assigns(:campaign)).to eq(campaign)
    end

    it "renders the show template" do
      get :show, id: campaign.id
      expect(response).to render_template(:show)
    end
  end

  describe "#index" do
    it "assigns campaigns instance variable to created campaigns" do
      campaign
      campaign_1
      get :index
      expect(assigns(:campaigns)).to eq([campaign, campaign_1])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

  end

  describe "#edit" do

    it "renders the edit template" do
      get :edit, id: campaign.id
      expect(response).to render_template(:edit)
    end

    it "retrieves the campaign with passed id and stores it in an instance variable" do
      get :edit, id: campaign.id
      expect(assigns(:campaign)).to eq(campaign)
    end

  end

  describe "#update" do

    context "with valid request" do

      before do
        patch :update, { id: campaign.id,
          campaign: {
            title: "Heyy Durr",
            description: "Loren ipsum heroku starbucks",
            goal: 11,
            due_date: "2019-11-11 10:33:20"
            }
          }  
      end

      it "redirect to the campaign show page" do
        expect(response).to redirect_to(campaign_path(campaign.id))
      end

      it "changes the title of the campaign if it's different" do
        campaign.reload
        expect(campaign.title).to eq("Heyy Durr")
      end

    end

    context "with invalid params" do

      before do
        patch :update, { id: campaign.id,
          campaign: {
            title: "",
            description: "Loren ipsum heroku starbucks",
            goal: 5,
            due_date: "2019-11-11 10:33:20"
            }
          }  
      end

      it "renders the edit page" do
        expect(response).to render_template(:edit)
      end

      it "doesn't change the database" do
        expect(campaign.reload.goal).not_to eq(5)
        # expect(assigns(:campaign)).to eq(campaign)
      end

      it "sets an alert flash message" do
        expect(flash[:alert]).to be
      end

    end

  end

  describe "#destroy" do

    let!(:campaign) { create(:campaign) }

    def destroy_request
      delete :destroy, id: campaign.id
    end

    it "deleted the database from the database" do
      expect{destroy_request}.to change { Campaign.count }.by(-1)
    end

    it "redirect to the home page" do
      expect(destroy_request).to redirect_to(root_path)
    end

    it "sets a flash message" do
      destroy_request
      expect(flash[:notice]).to be
    end

  end

end
