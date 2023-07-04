class ApplicationController < ActionController::Base
  include ActionController::MimeResponds
  skip_forgery_protection
  
end
