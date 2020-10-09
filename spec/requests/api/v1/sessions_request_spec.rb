require 'rails_helper'

RSpec.describe 'Api::V1::Sessions', type: :request do
  let(:parsed_response) { JSON.parse(response.body, serialize_names: true) }

  before :each do
    @member = create :member
    @service = create :service_app
    @api_key = create :api_key, service_app_id: @service.id
  end

  describe 'POST #create' do
    it 'returns ok status, member username and token' do
      params = { username: @member.username, password: @member.password }
      auth = { Authorization: authenticate_with_token(@api_key.session_token) }

      post api_v1_sign_in_path, headers: auth, params: params, as: :json

      expect(response.status).to eq 200
      expect(parsed_response['token']).to eq @member.token
      expect(parsed_response['username']).to eq @member.username
    end
  end

  describe 'POST #destroy' do
    it 'returns ok status and modifies member token' do
      params = { username: @member.username }
      auth = { Authorization: authenticate_with_tokens(@api_key.access_token, @member.token) }

      post api_v1_sign_out_path, headers: auth, params: params, as: :json

      past_token = @member.token
      @member.reload

      expect(response.status).to eq 200
      expect(@member.token).not_to eq past_token
    end
  end
end
