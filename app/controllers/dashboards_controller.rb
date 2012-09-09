class DashboardsController < ApplicationController
  respond_to :html, :json

  def index
    respond_with(@request = Request.new)
  end
end
