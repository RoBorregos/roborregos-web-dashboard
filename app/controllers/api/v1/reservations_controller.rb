class Api::V1::ReservationsController < Api::V1::BaseController
  def index
    
    @reservations = Reservation.all

    render json: @reservations
  end

  def show
    @reservation = Reservation.find(params[:id])
    
    render json: @reservation
  end
  
  #https://stackoverflow.com/questions/3364492/actioncontrollerinvalidauthenticitytoken
  def create
    @reservation = Reservation.new(member: Member.find_by(username: params[:username]))
  end

  def showHistoryByUsername
    @reservations = Reservation.where(member: Member.find_by(username: params[:username]))
    @reservationsDetails = ReservationDetail.select('reservation_id, component_id, COUNT(*) as quantity, cast(created_at as date) as created_date, cast(returned_at as date) as returned_date').where(reservation: @reservations).where(returned: true).group(:component_id,:reservation_id,:created_date,:returned_date)
    render json: @reservationsDetails
  end

  def showCurrentByUsername
    @reservations = Reservation.where(member: Member.find_by(username: params[:username]))
    @reservationsDetails = ReservationDetail.select('reservation_id, component_id, COUNT(*) as quantity, cast(created_at as date) as created_date').where(reservation: @reservations).where.not(returned: true).group(:component_id,:reservation_id,:created_date)
    render json: @reservationsDetails
  end

end
