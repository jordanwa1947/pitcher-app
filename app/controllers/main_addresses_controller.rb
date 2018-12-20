class MainAddressesController < ApplicationController

  def create
    main_address = MainAddress.new(address_params)
    main_address.user_id = params[:user_id].to_i
    main_address.save!
    flash[:success] = 'Main Address Updated'
    redirect_to :dashboard
  end

  def destroy

  end

  private

  def address_params
    params.require(:main_address).permit(:address, :city, :state, :zip)
  end
end
