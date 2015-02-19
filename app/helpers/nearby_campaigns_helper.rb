module NearbyCampaignsHelper

  def generate_markers(campaigns)
    Gmaps4rails.build_markers(campaigns) do |campaign, marker|
      marker.lat campaign.latitude
      marker.lng campaign.longitude
      link = link_to campaign.title, campaign_path(campaign)
      desc = campaign.description.truncate(50)
      marker.infowindow "<h4>#{link}</h4><br />#{desc}"
    end
  end
  
end
