class Api::V1::BaseController < ApplicationController
  before_action :authorize_service
  protect_from_forgery with: :null_session
  
  private

  def authorize_service
    authenticate_or_request_with_http_token do |token, options|
      if ApiKey.exists?(session_token: token) ||
        (ApiKey.exists?(access_token: token) && Member.exists?(token: options[:member_token]))
        @member_token = options[:member_token] if options[:member_token].present?
        true
      end
    end
  end
end
