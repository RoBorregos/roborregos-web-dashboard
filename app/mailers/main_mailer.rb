class MainMailer < ApplicationMailer

  def sample_email(member)
    @member = member
    mail(to: @member.email, subject: 'Sample Email')
  end

  def join_request(from_name, message, reply_to)
    @from_name = from_name
    @message = message
    @reply_to = reply_to
    mail(to: "roborregosteam@gmail.com", subject: from_name + ' wants to join!')
  end

  def join_request_response(from_name, position, reply_to)
    @from_name = from_name
    @position = position
    @reply_to = reply_to
    mail(to: reply_to, subject: 'Thanks for Applying ' + from_name)
  end

  def reservation_email(member, reservation)
    @member = member
    @reservationsDetails = ReservationDetail.select('component_id, COUNT(*) as quantity, uuid, cast(created_at as date) as created_date').where(reservation: reservation).group(:component_id, :uuid, :created_date)
    mail(to: @member.email, subject: 'Roborregos Almácen | Confirmación de Reservación')
  end
end
