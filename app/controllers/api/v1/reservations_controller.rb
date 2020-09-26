class Api::V1::ReservationsController < Api::V1::BaseController
  def index
    case params[:showValue].to_i
    when 1
      showAll
    when 2
      showHistory
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
    @reservation = Reservation.where(id:params[:id], member: Member.find_by(token: @member_token)).first
    @reservationDetails = ReservationDetail.select('reservation_id, component_id, COUNT(*) as quantity, cast(created_at as date) as created_date, cast(returned_at as date) as returned_date').where(reservation: @reservation).group(:component_id,:reservation_id,:created_date,:returned_date)
    if @member_token.present? && params[:id].present?
      @status = 200
      @message = t('messages.success_request')
      if @reservation.present?
        @data = {'id' => @reservation.id, 'details' => @reservationDetails, 'created_at' => @reservation.created_at, 'updated_at' => @reservation.updated_at}
      else
        @data = nil
      end
    else
      @status = 400
      @message = t('messages.failed_request')
      @data = nil
    end
    render json: {status:@status, message: @message,data: @data}
  end

  def create
    @reservation = Reservation.new(member: Member.find_by(token: @member_token))
    if params[:details].present? && @reservation.save
      params[:details].map { |detail|
        i = 0
        quantity = detail[:quantity].to_i
        while i < quantity
          @reservationsDetail = ReservationDetail.new(reservation: @reservation, component_id: detail[:component])
          @reservationsDetail.save
          i = i + 1
        end 
      }
      @status = 200
      @message = t('messages.success_request')
      @data = @reservation
    else
      @status = 400
      @message = t('messages.failed_request') + " - " + @reservation.errors.full_messages.join(', ')
      @data = nil
    end
    render json: {status:@status, message: @message,data: @data};
  end

  def update
    if params[:details].present? 
      @reservation = Reservation.find_by(id:params[:id], member: Member.find_by(token: @member_token))
      
      params[:details].map { |detail|
        d = DateTime.now
        d.strftime("%Y/%m/%d")
        i = 0
        quantity = detail[:quantity].to_i
        while i < quantity
          @reservationsDetail = ReservationDetail.where(reservation: @reservation, component_id: detail[:component]).where.not(returned: true).take
          @reservationsDetail.returned = true
          @reservationsDetail.returned_at = d.strftime("%Y/%m/%d")
          @reservationsDetail.save
          i = i + 1
        end 
      }
      @status = 200
      @message = t('messages.success_request')
      @data = @reservation
    else
      @status = 400
      @message = t('messages.failed_request') + " - " + @reservation.errors.full_messages.join(', ')
      @data = nil
    end
    render json: {status:@status, message: @message,data: @data};
  end

  private

  def showHistory
    @reservations = Reservation.where(member: Member.find_by(token: @member_token))
    @reservationlist = @reservations.map { |reservation|
      @reservationsDetails = ReservationDetail.select('component_id, COUNT(*) as quantity, cast(created_at as date) as created_date, cast(returned_at as date) as returned_date').where(reservation: reservation).where(returned: true).group(:component_id, :created_date, :returned_date)
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
      @reservationsDetails = ReservationDetail.select('component_id, COUNT(*) as quantity, cast(created_at as date) as created_date, cast(returned_at as date) as returned_date').where(reservation: reservation).where.not(returned: true).group(:component_id, :created_date, :returned_date)
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

  def showAll
    @reservations = Reservation.where(member: Member.find_by(token: @member_token))
    @reservationlist = @reservations.map { |reservation|
      @reservationsDetails = ReservationDetail.select('component_id, COUNT(*) as quantity, cast(created_at as date) as created_date, cast(returned_at as date) as returned_date').where(reservation: reservation).group(:component_id, :created_date, :returned_date)
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
