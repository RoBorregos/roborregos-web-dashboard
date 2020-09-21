require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:reservation) { FactoryBot.build(:reservation) }
  subject { reservation }

  context 'validations' do
    it { should validate_presence_of(:member) }
    it { should be_valid }
  end

  context 'associations' do
    it { should have_many(:reservation_details) }
    it { should belong_to(:member) }
  end
end
