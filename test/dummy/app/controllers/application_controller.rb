class ApplicationController < ActionController::Base
  protect_from_forgery

# This is handy for debugging
#  rescue_from Exception do |exception|
#    pp :ERROR, exception, exception.backtrace
#    raise
#  end

end # class ApplicationController