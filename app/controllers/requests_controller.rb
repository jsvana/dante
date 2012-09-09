class RequestsController < ApplicationController
  respond_to :html, :json, :js

  def index
    @music = Request.where(request_type: 'music')
    @movies = Request.where(request_type: 'movies')
    @tv_shows = Request.where(request_type: 'tv-shows')
    @software = Request.where(request_type: 'software')
    @games = Request.where(request_type: 'games')
    @other = Request.where(request_type: 'other')
    respond_with(@music, @movies, @tv_shows,
      @software, @games, @other)
  end

  def create
    puts params
    Request.create(params[:request])

    render 'create_request'
  end
end
