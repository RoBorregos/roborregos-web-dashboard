class Api::V1::MembersController < Api::V1::BaseController
  def index
    params[:sort_by] ||= :generation

    @members = {
      role: Member.all.sorted_by_role,
      major: Member.all.sorted_by_major,
      status: Member.all.sorted_by_status,
      generation: Member.all.sorted_by_generation,
    }.fetch(params[:sort_by]&.to_sym)

    render json: @members
  end

  def show
    @member = Member.find(params[:id])
    
    render json: @member
  end
  
  def showByUsername
    @member = Member.find_by(username: params[:username])
    
    render json: @member
  end
  
end
