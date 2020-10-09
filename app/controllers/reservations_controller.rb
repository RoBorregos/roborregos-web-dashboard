class ReservationsController < BaseController
  def index
    showHistory
  end

  private

  def showHistory
    @reservationsList = Reservation.all
    @reservations = @reservationsList.map { |reservation|
      status = 
      @reservationsDetails = ReservationDetail.select('component_id, COUNT(*) as quantity, status').where(reservation: reservation).group(:component_id, :status)
      status = ReservationDetail.where(reservation: reservation).minimum("status")
      { :id => reservation.id, :member => reservation.member, :details => @reservationsDetails, :created_at => reservation.created_at, :updated_at => reservation.updated_at, :status => status}
    }
  end
  
end
