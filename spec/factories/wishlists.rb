FactoryBot.define do
  factory :wishlist do
    user       { nil }
    restaurant { nil }
    # sequence(:yelp_id) { |n| n += 1}
  end
end
