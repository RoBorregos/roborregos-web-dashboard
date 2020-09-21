require 'rails_helper'

RSpec.describe ReservationDetail, type: :model do
  let(:reservation_detail) { FactoryBot.build(:reservation_detail) }
  subject { reservation_detail }

  context 'validations' do
    it { should validate_presence_of(:reservation) }
    it { should validate_presence_of(:component) }
    it { should be_valid }
  end

  context 'associations' do
    it { should belong_to(:reservation) }
    it { should belong_to(:component) }
  end
end
