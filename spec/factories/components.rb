FactoryBot.define do
  factory :component do
    name { FFaker::Name.first_name }
    img_path { FFaker::Internet.http_url }
    stock { 10 }
    component_category
  end
end
