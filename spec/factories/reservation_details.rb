FactoryBot.define do
  factory :reservation_detail do
    status        { 'requested' }
    
    reservation
    component
  end
end
