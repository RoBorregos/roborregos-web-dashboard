# Preview all emails at http://localhost:3000/rails/mailers/main_mailer
class MainMailerPreview < ActionMailer::Preview
    def reservation_email_preview
        MainMailer.reservation_email(Member.first, Reservation.where(:member => Member.first))
    end
end
