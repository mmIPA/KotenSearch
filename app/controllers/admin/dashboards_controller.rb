class Admin::DashboardsController < ApplicationController
    before_action :authenticate_admin!

end