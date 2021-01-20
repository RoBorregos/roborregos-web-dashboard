class Api::V1::MailsController < Api::V1::BaseController
  def join_mail
    #Send Email
    MainMailer.join_request(params[:from_name], params[:message], params[:reply_to]).deliver
    MainMailer.join_request_response(params[:from_name], params[:position], params[:reply_to]).deliver

    @status = 200
    @message = t('messages.success_request')
    @data = nil
    render json: {status:@status, message: @message,data: @data};
  end  
end
