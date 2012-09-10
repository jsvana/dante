class RequestsController < ApplicationController
  respond_to :html, :json, :js

  def index
    @music = Request.where(request_type: 'music')
    @movies = Request.where(request_type: 'movies').order('vote DESC')
    @tv_shows = Request.where(request_type: 'tv-shows')
    @software = Request.where(request_type: 'software')
    @games = Request.where(request_type: 'games')
    @other = Request.where(request_type: 'other')
    respond_with([@music, @movies, @tv_shows,
      @software, @games, @other])
  end

  def new
    respond_with(@request = Request.new)
  end

  def create
    Request.create(params[:request])

    render 'create_request'
  end

  def upvote
    @request = Request.find(params[:id])

    @request.vote += 1

    @request.save

    respond_with(@request)
  end

  def downvote
    @request = Request.find(params[:id])

    @request.vote -= 1

    @request.save

    respond_with(@request)
  end
end
