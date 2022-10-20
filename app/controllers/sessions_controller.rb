class SessionsController < ApplicationController


	def new; end

	def home
	end
	

	def create
		user = User.find_by(email: params[:email])
		if user.present? && user.authenticate(params[:password])
			session[:user_id] = user.id
			bank = Bank.find_by(user_id: session[:user_id])
			if !bank.present?
				redirect_to home_path, notice:"Create Your Bank account Here!!"
			else
				redirect_to new_path
			end
		else
			flash.now[:alert] = 'Invalid email or password'
			render :new
		end
	end
	def destroy
		session[:user_id] = nil
		redirect_to root_path, notice: 'Logged out'
	end
end
