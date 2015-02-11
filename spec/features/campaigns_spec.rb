require 'rails_helper'

RSpec.feature "Campaigns", type: :feature do
  let(:user) { create(:user) }
  describe "Home Page / Listing Campaigns" do
    it "displays a welcome message" do
      visit root_path
      expect(page).to have_text "Welcome to Fund.sy"
    end
    it "displays a title for the page" do
      visit root_path
      expect(page).to have_title "Fund.sy Crowdfunding"
    end
    context "with campaigns" do
      let!(:campaign) { create(:campaign) }
      let!(:campaign_1) { create(:campaign) }
      it "displays campaign's title" do
        visit root_path
        expect(page).to have_text /#{campaign.title}/i
      end
      it "displays campaign titles in h2 elements" do
        visit root_path
        # save_and_open_page # opens a page even if server not running via Launchy
        expect(page).to have_selector "h2", campaign_1.title
      end
    end
  end
  describe "creating a campaign" do
    it "creates a campaign and redirects to show page" do
      login_via_web(user)
      visit new_campaign_path
      attributes = attributes_for :campaign
      fill_in "Title", with: attributes[:title]
      fill_in "Description", with: attributes[:description]
      fill_in "Goal", with: attributes[:goal]
      click_button "Submit"
      expect(current_path).to eq(campaign_path(Campaign.last))
      expect(Campaign.count).to eq(1)
      expect(page).to have_text /Campaign created!/i
    end
  end
end
