module UserHelper
  class User
    attr_accessor :username

    def initialize(username)
      @username = username
    end
  end
end
