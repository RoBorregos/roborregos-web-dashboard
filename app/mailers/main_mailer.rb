require 'rqrcode_png'
class MainMailer < ApplicationMailer

  def sample_email(member)
    @member = member
    mail(to: @member.email, subject: 'Sample Email')
  end
  def reservation_email(member, reservation)
    @member = member
    @reservationsDetails = ReservationDetail.select('component_id, COUNT(*) as quantity, uuid, cast(created_at as date) as created_date').where(reservation: reservation).group(:component_id, :uuid, :created_date)
    mail(to: @member.email, subject: 'Roborregos Almácen | Confirmación de Reservación')
  end
end
