class UserMailer < ApplicationMailer
	default from: 'notifications@example.com'
 
	def job_email(job)
	  @job = job
	  @url  = 'http://example.com/login'
	  @host= @job.host.fullname
	  @email = @job.host.email
	  mail(to: @email, subject: 'Job Create Success')
	end

	def booking_email(booking)
	  @booking = booking
	  @url  = 'http://example.com/login'
	  @host= @booking.job.host.fullname
	  recipients = [@booking.job.host.email, @booking.user.email]
	  mail(to: recipients, subject: 'New Booking')

	end

	def booking1_email(booking)
	  @booking = booking
	  @url  = 'http://example.com/login'
	  @host= @booking.job.host.fullname
	  recipients = [@booking.job.host.email, @booking.user.email]
	  mail(to: recipients, subject: 'New Booking And Confirmation')
	end

	def confirm_email(booking)
	  @booking = booking
	  @url  = 'http://example.com/login'
	  @host= @booking.job.host.fullname
	  recipients = [@booking.user.email]
	  mail(to: recipients, subject: 'Confirmation For Job Apply')
	end
end
