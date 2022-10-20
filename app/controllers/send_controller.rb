class SendController < ApplicationController
	  before_action :set_current_user

	def set_current_user
	  Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
	end
  

def new
  @history = History.new
end

def sending

  @bank = Bank.find_by(user_id: session[:user_id])
  bal = @bank[:balance].to_i
  b2 = bank_params[:balanc].to_i
  @bankto = Bank.find_by(acc_number: bank_params[:acno])
  bal2 = @bankto[:balance].to_i

  if bal > b2

    new_bal = bal - b2
    new_bal = { :balance => new_bal }

    new_bal2 = bal2 + b2
    new_bal2 = { :balance => new_bal2 }
    tran_history
    if @bank.update(new_bal) && @bankto.update(new_bal2)
      redirect_to new_path
    else
      render json: { errors: @bank.errors.full_messages}
    end

  else

    redirect_to new_path
    flash.alert = "Insufficient balance"
  end
end

def tran_history
    puts "......................................................................................"
    # @history = History.new(params[:history])
    # puts params[:history]
    @banks = Bank.find_by(user_id: session[:user_id])
    @sender = Bank.find_by(user_id: session[:user_id])
    user_id = @banks.user_id
    acc_number = @sender.acc_number
    amount = -bank_params[:balanc].to_i
    trans_no = (54621050*rand(1..9))/rand(1..8)
    trans_to = bank_params[:acno]
    t_type = "Debited from your A/C "
    @history = History.new(:user_id => user_id, :acc_number => acc_number, :amount => amount, :trans_no => trans_no, :trans_to => trans_to, :t_type => t_type)
    p "*******************************************************************************************"
    p @history
    if @history.save
      p "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      session[:history_id] = @history.id
      @sendto = Bank.find_by(acc_number: bank_params[:acno])
      user_id = @sendto.user_id
      acc_number = bank_params[:acno]
      amount = +bank_params[:balanc].to_i
      trans_no = (54621050*rand(1..9))/rand(1..8)
      trans_to = @sender.acc_number
      t_type = "Credited to your A/C"
      @history = History.new(:user_id => user_id, :acc_number => acc_number, :amount => amount, :trans_no => trans_no, :trans_to => trans_to, :t_type => t_type)
      if @history.save
        p "................................................................"
        session[:history_id] = @history.id
    #     redirect_to new path
        return

    #     flash.alert = "transaction success"
    #   else
    #     render json: { errors: @history.errors.full_messages}
      end
    # else
    #   render json: { errors: @history.errors.full_messages}

        return
      else
        # render json: { errors: @history.errors.full_messages}
        puts "------------------------------------------------------------------"
        puts "no save"
        return
    end
    


  end
end
private
def bank_params
  params.require(:bank).permit(:balanc, :acno)
end

