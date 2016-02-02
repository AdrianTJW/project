class TransactionsController < ApplicationController
	before_action :authenticate_user!
  def new
  	@client_token = generate_client_token
  end

  def host_create
  	@result = Braintree::PaymentMethod.create(
  		id: current_host.id,
      first_name: current_host.fullname,
      email: current_host.email,
      contact: current_host.contact,
      payment_method_nonce: nonce_from_the_client,
      :options => {
        :verify_card => true,
      }
    )
  end

  def host_update
  	@result = Braintree::Customer.update(
  		"a_customer_id",
      first_name: current_host.fullname,
      email: current_host.email,
      contact: current_host.contact,
      payment_method_nonce: nonce_from_the_client,
      :options => {
        :verify_card => true,
      }
    )
  end


  private
	def generate_client_token
	  if current_user.has_payment_info?
	    Braintree::ClientToken.generate(customer_id: current_user.braintree_customer_id)
	  else
	    Braintree::ClientToken.generate
	  end
	end
end
