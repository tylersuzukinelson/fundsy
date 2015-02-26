FactoryGirl.define do
  factory :pledge do
    amount 1
stripe_txn_id "MyString"
aasm_state "MyString"
user nil
reward_level nil
  end

end
