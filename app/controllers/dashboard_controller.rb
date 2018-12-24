class DashboardController < ApplicationController
  before_action :authenticate

  def show
    @main_address = MainAddress.find_by(user: current_user) || MainAddress.new
  end

end
