class Api::V1::SessionsController < Api::V1::BaseController
  # TODO:
  #   research about how to delete this line
  protect_from_forgery with: :null_session

  def create
    member = Member.find_by(username: params[:username])

    if member&.valid_password?(params[:password])
      render json: member.as_json(only: [:username, :token]), status: 200
    else
      head(:unauthorized)
    end
  end

  def destroy
    member = Member.find_by(username: params[:username])

    if member&.token == @member_token
      begin
        token = SecureRandom.uuid
      end while Member.exists?(token: token)

      member.update(token: token)
      render json: member.as_json(only: [:username]), status: 200
    else
      head(:unauthorized)
    end
  end
end
