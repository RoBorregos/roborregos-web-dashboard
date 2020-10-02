class Api::V1::ReservationsController < Api::V1::BaseController
  def index
    case params[:showValue].to_i
    when 1
      showHistory
    when 2
      showReturned
    when 3
      showCurrent
    else
      @status = 400
      @message = t('messages.failed_request')
      @data = nil
      render json: {status:@status, message: @message,data: @data};
    end
  end

  def show
    if ReservationDetail.exists?(uuid: params[:id])
      if ReservationDetail.where(status:1,uuid: params[:id]).exists?
        @details = ReservationDetail.where(status:1,uuid: params[:id])
        @data = @details.map { |detail|
        {:id => detail.id, :component_id => detail.component_id, :component_category => detail.component.component_category_id, :created_at => detail.created_at}
        }
        @details.update_all(delivered_at: DateTime.now,uuid: "",status: 2)
      else
        @details = ReservationDetail.where(status:3,uuid: params[:id])
        @data = @details.map { |detail|
        {:id => detail.id, :component_id => detail.component_id, :component_category => detail.component.component_category_id, :created_at => detail.created_at}
        }
        @details.update_all(received_at: DateTime.now,uuid: "",status: 4)
      end
    else
      @data = nil  
    end
    @status = 200
    @message = t('messages.success_request')
    render json: {status:@status, message: @message,data: @data}
  end

  def create
    @reservation = Reservation.new(member: Member.find_by(token: @member_token))
    begin
      @uuidReservationDetail = SecureRandom.uuid
    end while ReservationDetail.exists?(uuid: @uuidReservationDetail)
    
    if params[:details].present? && @reservation.save
      params[:details].map { |detail|
        i = 0
        quantity = detail[:quantity].to_i
        while i < quantity
          @reservationsDetail = ReservationDetail.new(reservation: @reservation, component_id: detail[:component], uuid: @uuidReservationDetail, status: 1)
          @reservationsDetail.save
          i = i + 1
        end 
      }
      @status = 200
      @message = t('messages.success_request')
      @data = { :id => @reservation.id, :uuid => @uuidReservationDetail, :member => @reservation.member_id, :created_at => @reservation.created_at, :updated_at => @reservation.updated_at}
    else
      @status = 400
      @message = t('messages.failed_request') + " - " + @reservation.errors.full_messages.join(', ')
      @data = nil
    end
    render json: {status:@status, message: @message,data: @data};
  end

  def update
    if params[:details].present? 
      begin
        @uuidReservationDetail = SecureRandom.uuid
      end while ReservationDetail.exists?(uuid: @uuidReservationDetail)

      @reservation = Reservation.find_by(member: Member.find_by(token: @member_token))
      
      params[:details].map { |detail|
        i = 0
        quantity = detail[:quantity].to_i
        while i < quantity
          @reservationsDetail = ReservationDetail.where(reservation: @reservation, component_id: detail[:component]).where(status: 2).take
          if @reservationsDetail.present?
            @reservationsDetail.returned_at = DateTime.now
            @reservationsDetail.status = 3
            @reservationsDetail.uuid = @uuidReservationDetail
            @reservationsDetail.save
          end
          i = i + 1
        end 
      }
      @status = 200
      @message = t('messages.success_request')
      @data = { :uuid => @uuidReservationDetail, :member => @reservation.member_id}
    else
      @status = 400
      @message = t('messages.failed_request') + " - " + @reservation.errors.full_messages.join(', ')
      @data = nil
    end
    render json: {status:@status, message: @message,data: @data};
  end

  private

  def showReturned
    @reservations = Reservation.where(member: Member.find_by(token: @member_token))
    @reservationlist = @reservations.map { |reservation|
      @reservationsDetails = ReservationDetail.select('component_id, COUNT(*) as quantity, cast(created_at as date) as created_date, cast(returned_at as date) as returned_date').where(reservation: reservation).where("status = 4").group(:component_id, :created_date, :returned_date)
      if @reservationsDetails.present?
        { :id => reservation.id, :details => @reservationsDetails, :created_at => reservation.created_at, :updated_at => reservation.updated_at}
      else
        nil
      end
    }.compact
    if @member_token.present?
      @status = 200
      @message = t('messages.success_request')
      @data = @reservationlist
    else
      @status = 400
      @message = t('messages.failed_request')
      @data = nil
    end
    render json: {status:@status, message: @message,data: @data};
  end

  def showCurrent
    @reservations = Reservation.where(member: Member.find_by(token: @member_token))
    @reservationlist = @reservations.map { |reservation|
      @reservationsDetails = ReservationDetail.select('component_id, COUNT(*) as quantity, cast(created_at as date) as created_date, cast(returned_at as date) as returned_date, status').where(reservation: reservation).where("status < 4").group(:component_id, :created_date, :returned_date, :status)
      if @reservationsDetails.present?
        { :id => reservation.id, :details => @reservationsDetails, :created_at => reservation.created_at, :updated_at => reservation.updated_at}
      else
        nil
      end
    }.compact
    if @member_token.present?
      @status = 200
      @message = t('messages.success_request')
      @data = @reservationlist
    else
      @status = 400
      @message = t('messages.failed_request')
      @data = nil
    end
    render json: {status:@status, message: @message,data: @data};
  end

  def showHistory
    @reservations = Reservation.where(member: Member.find_by(token: @member_token))
    @reservationlist = @reservations.map { |reservation|
      @reservationsDetails = ReservationDetail.select('component_id, COUNT(*) as quantity, cast(created_at as date) as created_date, cast(returned_at as date) as returned_date, status').where(reservation: reservation).group(:component_id, :created_date, :returned_date, :status)
      { :id => reservation.id, :details => @reservationsDetails, :created_at => reservation.created_at, :updated_at => reservation.updated_at}
    }
    if @member_token.present?
      @status = 200
      @message = t('messages.success_request')
      @data = @reservationlist
    else
      @status = 400
      @message = t('messages.failed_request')
      @data = nil
    end
    render json: {status:@status, message: @message,data: @data};
  end
  
end
