require 'rails_helper'

RSpec.describe 'Api::V1::Members', type: :request do
  let(:parsed_response) { JSON.parse(response.body, symbolize_names: true) }

  before :each do
    @member = create :member
    @service = create :service_app
    @api_key = create :api_key, service_app_id: @service.id
  end

  describe 'GET #index' do
    it 'returns an array of 5 objects' do
      auth = { Authorization: authenticate_with_tokens(@api_key.access_token, @member.token) }

      create_list :member, 5

      get api_v1_members_path, headers: auth, :params => {:showAll => 1}, as: :json

      expect(response.status).to eq 200
      expect(parsed_response.size).to eq 6
    end
  end
end
