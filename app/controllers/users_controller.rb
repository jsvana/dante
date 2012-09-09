class UsersController < ApplicationController
  respond_to :html, :json

  def index
    respond_with(@users = User.all)
  end

  def show
    respond_with(@user = User.find(params[:id]))
  end

  def new
    respond_with(@user = User.new)
  end

  def create
    respond_with(@user = User.create(params[:user]))
  end
end
