class MainAddressesController < ApplicationController

  def create
    main_address = MainAddress.new(address_params)
    main_address.user_id = params[:user_id].to_i
    main_address.save!
    flash[:success] = 'Main Address Updated'
    redirect_to :dashboard
  end

  def destroy
    main_address = MainAddress.find(params[:id])
    main_address.delete
    redirect_to dashboard_path 
  end

  def edit
    @main_address = current_user.main_address
  end

  def update
    main_address = MainAddress.find(params[:id])
    main_address.update(address_params)
    flash[:success] = "You're Main Address Has Been Updated"
    redirect_to dashboard_path
  end

  private

  def address_params
    params.require(:main_address).permit(:address, :city, :state, :zip)
  end
end
