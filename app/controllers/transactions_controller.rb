class TransactionsController < ApplicationController

  def new
    if current_user || current_host
      @job = Job.find_by(id: params[:job_id])
      gon.client_token = generate_client_token
      if params[:booking_id].nil? == false
        @booking = Booking.find_by(id: params[:booking_id])
      end
    else
      flash[:error] = "Please log in first."
      redirect_to root_path
    end
  end

  def create
    @job = Job.find_by(id: params[:job_id])
    if current_user && current_user.has_payment_info?
    	@result = Braintree::Transaction.sale(
                amount: @job.salary,
                payment_method_nonce: params[:payment_method_nonce])
    elsif current_host && current_host.has_payment_info?
      @result = Braintree::Transaction.sale(
                amount: ActionController::Base.helpers.number_with_precision(@job.salary * 0.05, precision: 2),
                payment_method_nonce: params[:payment_method_nonce])
    else
      if current_user
        @amount = @job.salary
      else
        @amount = ActionController::Base.helpers.number_with_precision(@job.salary * 0.05, precision: 2)
      end
      @result = Braintree::Transaction.sale(
                amount: @amount,
                payment_method_nonce: params[:payment_method_nonce],
                customer: {
                  first_name: params[:fullname],
                  email: params[:email],
                  phone: params[:contact]
                },
                options: {
                  store_in_vault: true,
                })      
    end
    if @result.success?
      if current_user
        current_user.update(braintree_customer_id: @result.transaction.customer_details.id) unless current_user.has_payment_info?
        @booking = Booking.create(user_id: current_user.id, job_id: params[:job_id], paid_status: true)
        if @booking.job.type == "Volunteering" || @booking.job.type == "Bootcamp"
          @booking.update(acceptance: true)
        end
        flash[:notice] = 'Application was successfully created.'
        redirect_to jobs_path      
      end

      if current_host
        current_host.update(braintree_host_id: @result.transaction.customer_details.id) unless current_host.has_payment_info?
        @booking = Booking.find_by(id: params[:booking_id])
        @booking.update(acceptance: true, paid_status: true)
        flash[:notice] = 'Application is accepted.'
        redirect_to jobs_path
      end
    else
      flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
      gon.client_token = generate_client_token
      render :new
    end
  end

  private
	def generate_client_token
    if current_user.nil?
      if current_host.has_payment_info?
        Braintree::ClientToken.generate(customer_id: current_host.braintree_host_id)
      else
        Braintree::ClientToken.generate
      end
    else
	    if current_user.has_payment_info?
        Braintree::ClientToken.generate(customer_id: current_user.braintree_customer_id)
      else
        Braintree::ClientToken.generate
      end
    end
	end
end
