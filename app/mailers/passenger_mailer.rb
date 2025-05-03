class PassengerMailer < ApplicationMailer
  def thanks_email
    @passenger = params[:passenger]
    @url = 'http://example.com/login'
    mail(to: @passenger.email, subject: 'Thank you for booking a flight with us')

  end  
end
