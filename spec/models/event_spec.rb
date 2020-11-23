require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { FactoryBot.build(:event) }
  subject { event }

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:start_date) }
    it { should be_valid }
  end

  context 'associations' do
    it { should belong_to(:sponsor).optional }
    it { should have_many(:event_members) }
    it { should have_many(:members).through(:event_members) }
  end
end
