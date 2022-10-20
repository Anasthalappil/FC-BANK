class HomesController < ApplicationController
	before_action :set_current_user

	def set_current_user
		Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
	end

	# helper :headshot




	def home
		@bank = Bank.new
			# helper :headshot
	end

	def report
		@statement = History.all
		respond_to do |format|
			format.html
			format.xlsx do

				@statement = History.where(user_id: session[:user_id])
				render xlsx: 'statement', template: 'homes/statement'
			end
		end
	end

	def new
		@history = History.all
		@history.each do|bank|

			puts bank.acc_number,bank.amount
		end
	
		# @history = History.find_by(user_id: session[:user_id])
		# puts @history.acc_number,@history.amount
		@banks = Bank.all.with_attached_image
		@banks.each do|bank|

		if bank.image.present?
			puts "no image"
		end
		end
	end
	def show
		@history = History.find_by(user_id: session[:user_id])
		@history = History.all
	end

	def create
		@bank = Bank.new(bank_params)
		@bank.user_id = Current.user.id
		@bank.image.attach(params[:bank][:image])
		user = Bank.find_by(user_id: session[:user_id])
		if user.present?
			redirect_to new_path, notice: "You have a account!!!!"
		else
			@bank.balance = 0
			@bank.acc_number = 101050+Current.user.id
		if @bank.save
			session[:bank_id] = @bank.id

			redirect_to new_path, notice: "account created"
		else
			render :home, notice: "Failed"
		end
		end

	end

	private
	def bank_params
		params.require(:bank).permit(:user_id, :Name, :balance, :Place, :acc_number, :acc_type, :image)
		# .merge(c_id: session[:user_id]) #ith maatanam
	end

end
