class MainMailer < ApplicationMailer
  def sample_email(member)
    @member = member
    mail(to: @member.email, subject: 'Sample Email')
  end
end
