class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: ENV.fetch("ADMIN_USERNAME", "Jungle"), password: ENV.fetch("ADMIN_PASSWORD", "book")

  def show
    
  end
end
