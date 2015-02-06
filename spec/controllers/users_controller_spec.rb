require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "#new" do

    it "assigns a new user instance variable" do
      get :new
      # assigns(:user) refers to @user
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

  end

  describe "#create" do

    context "valid request" do

      def valid_request
        post :create, {
          user: {
            first_name: "Bob",
            last_name: "Smith",
            email: "bob@gmail.com",
            password: "12345678",
            password_confirmation: "12345678"
            }
          }  
      end

      it "creates a new user record in the database" do
        expect { valid_request }.to change { User.count }.by(1)
      end

      it "redirects to the home page" do
        valid_request
        expect(response).to redirect_to(root_path)
      end

      it "sets flash message" do
        valid_request
        expect(flash[:notice]).not_to be
      end

    end

    context "invalid request" do

      def invalid_request
        post :create, {
          user: {
            first_name: "Bob",
            last_name: "Smith",
            email: "bob@gmail",
            password: "12345678",
            password_confirmation: "12345678"
            }
          }  
      end

      it "doesn't create a record in the database" do
        expect { invalid_request }.not_to change { User.count }
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

end
