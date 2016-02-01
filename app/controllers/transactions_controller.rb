class TransactionsController < ApplicationController
	before_action :authenticate_user!
  def new
  	@client_token = generate_client_token
  end

  private
	def generate_client_token
	  Braintree::ClientToken.generate
	end
end
