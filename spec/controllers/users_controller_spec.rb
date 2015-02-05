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

end
