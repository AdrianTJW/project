class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 	def devise_parameter_sanitizer
 		if resource_class == User
 			UserParams.new(User, :user, params)
 		elsif resource_class == Host
 			HostParams.new(Host, :host, params)
 		elsif resource_class == Admin
 			AdminParams.new(Admin, :admin, params)
 		else
 			super
 		end
 	end
end

class UserParams < Devise::ParameterSanitizer
	def sign_in
		default_params.permit(:email, :password, :remember_me)
	end

	def sign_up
		default_params.permit(:fullname, :contact, :image, :email, :password, :password_confirmation)
	end

	def acount_update
		default_params.permit(:fullname, :contact, :image)
	end
end

class HostParams < Devise::ParameterSanitizer
	def sign_in
		default_params.permit(:email, :password, :remember_me)
	end

	def sign_up
		default_params.permit(:fullname, :contact, :image, :email, :password, :password_confirmation, :verify_status)
	end

	def acount_update
		default_params.permit(:fullname, :contact, :image, :verify_status)
	end
end

class AdminParams < Devise::ParameterSanitizer
	def sign_in
		default_params.permit(:email, :password, :remember_me)
	end

	def sign_up
		default_params.permit(:fullname, :email, :password, :password_confirmation)
	end

	def acount_update
		default_params.permit(:fullname)
	end
end