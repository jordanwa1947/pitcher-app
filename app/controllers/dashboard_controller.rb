class DashboardController < ApplicationController
  before_action :authenticate

  def show
    main_address = MainAddress.find_by(user_id: current_user.id)
    if main_address
      @main_address = main_address
    else
      @main_address = MainAddress.new
    end
  end
end
