FactoryBot.define do
  factory :main_address do
    address { "1331 17th Street" }
    city    { "Denver" }
    state   { "CO" }
    zip     { "80202" }
    user    { nil }
  end
end
