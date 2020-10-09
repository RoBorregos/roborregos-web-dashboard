require "rails_helper"

RSpec.describe MainMailer, type: :mailer do

  before :each do
    @member = create :member
    @reservation = create :reservation, member_id: @member.id
    @reservationDetail = create :reservation_detail, reservation_id: @reservation.id
  end

  describe "reservation_email" do
    let(:mail) { MainMailer.reservation_email(@member, @reservation) }

    it "renders the headers" do
      expect(mail.subject).to eq("Roborregos Almácen | Confirmación de Reservación")
      expect(mail.to).to eq([@member.email])
      expect(mail.from).to eq(["roborregoswarehouse@gmail.com"])
    end
  end
end
