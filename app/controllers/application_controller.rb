class ApplicationController < ActionController::Base
  respond_to :json
  include ActionController::MimeResponds
  skip_forgery_protection
  
end
