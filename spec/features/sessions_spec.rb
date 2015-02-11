require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  describe "Signing in" do
    let(:user) { create(:user) }
    it "redirects the user to the home page" do
      login_via_web(user)
      expect(current_path).to eq(root_path)
    end
  end
end
