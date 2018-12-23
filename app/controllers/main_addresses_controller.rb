class MainAddressesController < ApplicationController

  before_action :authenticate

  def create
    make_address
    if @main_address.save!
      flash[:success] = address_alert[:success]
      redirect_to :dashboard
    else
      flash[:failure] = address_alert[:failure]
      render :dashboard
    end
  end

  def destroy
    main_address = MainAddress.find(params[:id]).delete
    flash[:success] = address_alert[:deleted]
    redirect_to dashboard_path
  end

  def edit
    @main_address = current_user.main_address
  end

  def update
    MainAddress.find_by(user: current_user).delete
    make_address
    if @main_address.save!
      flash[:success] = address_alert[:success]
      redirect_to dashboard_path
    else
      flash[:error] = address_alert[:failture]
      render :dashboard
    end
  end

  private

  def address_alert
    {
      success: "You're Main Address Has Been Updated",
      failure: 'An Error Occured. Please Try Again',
      deleted: 'Main Address Has Been Deleted'
    }
  end

  def make_address
    @main_address      = MainAddress.new(address_params)
    @main_address.user = current_user
  end

  def address_params
    params.require(:main_address).permit(:address, :city, :state, :zip)
  end
end
