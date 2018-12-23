class DashboardController < ApplicationController
  before_action :authenticate

  def show
    must_be_logged_in
    if main_address = MainAddress.find_by(user_id: current_user.id)
      @main_address = main_address
    else
      @main_address = MainAddress.new
    end
  end
end
