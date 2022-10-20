class DepositController < ApplicationController
    before_action :set_current_user

  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end
  def index
    @bank = Bank.all
  end

def update
  @banks = Bank.find_by(user_id: session[:user_id])
  bal = @banks[:balance].to_i
  new_bal = bal + bank_params[:balance].to_i
  new_bal = { :balance => new_bal }
  tran_history
  if @banks.update(new_bal)
    redirect_to new_path, notice: "Success"
  else
    render json: { errors: @bank.errors.full_messages}
  end
end

def tran_history
    puts "......................................................................................"
    # @history = History.new(params[:history])
    # puts params[:history]
    @banks = Bank.find_by(user_id: session[:user_id])
    # @sender = Bank.find_by(user_id: session[:user_id])
    user_id = @banks.user_id
    acc_number = @banks.acc_number
    amount = bank_params[:balance].to_i
    puts "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
    trans_no = (54621050*rand(1..9))/rand(1..8)
    trans_to = @banks.acc_number
    t_type = "Credited to your A/C from Deposit"
    @history = History.new(:user_id => user_id, :acc_number => acc_number, :amount => amount, :trans_no => trans_no, :trans_to => trans_to, :t_type => t_type)
    p "*******************************************************************************************"
    p @history
    if @history.save
      p "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      session[:history_id] = @history.id
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

  private
  def bank_params
    params.require(:bank).permit(:balance)
    # .merge(c_id: session[:user_id]) #ith maatanam
  end
end
