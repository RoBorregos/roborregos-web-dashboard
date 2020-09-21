require 'rails_helper'

RSpec.describe Member, type: :model do
  let(:member) { FactoryBot.build(:member) }
  subject { member }

  context 'validations' do
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:major) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:generation) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:github_username) }
    it { should validate_presence_of(:fathers_last_name) }
    it { should validate_presence_of(:mothers_last_name) }
    it { should validate_uniqueness_of(:github_username) }
    it { should be_valid }
  end

  context 'associations' do
    it { should have_many(:team_members) }
    it { should have_many(:teams).through(:team_members) }
    it { should have_many(:arrangement_members) }
    it { should have_many(:arrangements).through(:arrangement_members) }
    it { should have_many(:event_members) }
    it { should have_many(:events).through(:event_members) }
    it { should have_many(:reservations) }
  end
end
