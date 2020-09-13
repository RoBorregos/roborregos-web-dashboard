require 'rails_helper'

RSpec.describe ComponentCategory, type: :model do
  let(:component_category) { FactoryBot.build(:component_category) }
  subject { component_category }

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should be_valid }
  end

  context 'associations' do
    it { should have_many(:components) }
  end
end
