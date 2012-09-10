class Request < ActiveRecord::Base
  attr_accessible :request_type, :artist, :album, :title, :vote
end
