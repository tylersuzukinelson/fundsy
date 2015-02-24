json.array! @campaigns do |campaign|
  json.id campaign.id
  json.title campaign.title.capitalize
  json.created_on formatted_date(campaign.created_at)
end