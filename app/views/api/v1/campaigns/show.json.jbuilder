json.title @campaign.title
json.description @campaign.description
json.goal number_to_currency(@campaign.goal)
json.due_date formatted_date(@campaign.due_date)
json.reward_levels @campaign.reward_levels do |rl|
  json.title rl.title
  json.amount rl.amount
  json.body rl.body
  json.quantity rl.quantity
end