class MainAddressesController < ApplicationController

  def create
    must_be_logged_in
    main_address = MainAddress.new(address_params)
    main_address.user_id = params[:user_id].to_i
    if main_address.save!
      flash[:success] = 'Main Address Updated'
      redirect_to :dashboard
    else
      flash[:failure] = 'An Error Occured. Please Try Again'
      render :dashboard
    end
  end

  def destroy
    must_be_logged_in
    main_address = MainAddress.find(params[:id])
    main_address.delete
    flash[:success] = 'Main Address Has Been Deleted'
    redirect_to dashboard_path
  end

  def edit
    must_be_logged_in
    @main_address = current_user.main_address
  end

  def update
    must_be_logged_in
    MainAddress.find_by(user_id: current_user.id).delete
    main_address = MainAddress.new(address_params)
    main_address.user_id = params[:user_id]
    if main_address.save!
      flash[:success] = "You're Main Address Has Been Updated"
      redirect_to dashboard_path
    else
      flash[:error] = "An Error Occured"
      render :dashboard
    end
  end

  private

  def address_params
    params.require(:main_address).permit(:address, :city, :state, :zip)
  end
end
