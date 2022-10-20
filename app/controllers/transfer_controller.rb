class TransferController < ApplicationController

  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def index
    @bank = Bank.find_by(user_id: session[:user_id])
    # @bankto = Bank.find_by(acc_number: params[:acc_number])
    # p @bankto
    # @bankto = Bank.all

  end

  def fetch
    @bank = Bank.find_by(acc_number: bank_params[:ac_number])
    if @bank.present?
      flash.alert = "success"
    else
      redirect_to new_path, notice:"please check the account number!!!!!!"
    end

  end
  private
  def bank_params
    params.require(:bank).permit(:ac_number)

  end
end
