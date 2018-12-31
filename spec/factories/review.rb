FactoryBot.define do

  factory :review do
    sequence(:title)  { |n| "Title#{n}" }
    rating            { rand(1..5) }
    sequence(:review) { |n| "Review#{n}" }
    user              { nil }
    restaurant        { nil }
  end

end
