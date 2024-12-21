module AdminPanel
  class DashboardsController < ApplicationController
    before_action :authenticate_admin!
  end
end