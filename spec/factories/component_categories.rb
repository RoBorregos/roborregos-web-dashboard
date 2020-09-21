FactoryBot.define do
  factory :component_category do
    name { FFaker::Name.first_name }
    description { FFaker::Lorem.sentence }
  end
end
