require 'rails_helper'

RSpec.describe Component, type: :model do
  let(:component) { FactoryBot.build(:component) }
  subject { component }

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:component_category) }
    it { should validate_presence_of(:img_path) }
    it { should be_valid }
  end

  context 'associations' do
    it { should belong_to(:component_category) }
    it { should have_many(:reservation_details) }
  end
end
