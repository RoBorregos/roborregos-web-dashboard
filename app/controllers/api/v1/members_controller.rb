class Api::V1::MembersController < Api::V1::BaseController
  def index
    @data = nil
    if params[:showAll]
      params[:sort_by] ||= :generation
      @members = {
        role: Member.all.sorted_by_role,
        major: Member.all.sorted_by_major,
        status: Member.all.sorted_by_status,
        generation: Member.all.sorted_by_generation,
      }.fetch(params[:sort_by]&.to_sym)

      @data = @members
    else
      @member = Member.find_by(token: @member_token)
      @data = @member
    end
    @status = 200
    @message = t('messages.success_request')
    render json: {status:@status, message: @message,data: @data};
  end

  def show
    if Member.where(id: params[:id]).empty?
      @status = 400
      @message = t('messages.failed_request')
      @data = nil
    else
      @status = 200
      @message = t('messages.success_request')
      @data = Member.find(params[:id])
    end
    render json: {status:@status, message: @message,data: @data};
  end
  
end
