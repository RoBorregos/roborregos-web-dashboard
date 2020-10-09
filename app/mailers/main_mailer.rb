class MainMailer < ApplicationMailer
  def sample_email(member)
    @member = member
    mail(to: @member.email, subject: 'Sample Email')
  end
  def reservation_email(member, reservation)
    @member = member
    @reservationsDetails = ReservationDetail.select('component_id, COUNT(*) as quantity, cast(created_at as date) as created_date, cast(returned_at as date) as returned_date').where(reservation: reservation).where("status >= 4").group(:component_id, :created_date, :returned_date)
    @ReservationDetail = ReservationDetail.where(:reservation => reservation).group_by()
    mail(to: @member.email, subject: 'Reservation Email')
  end
end
