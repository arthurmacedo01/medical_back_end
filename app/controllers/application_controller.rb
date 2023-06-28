class ApplicationController < ActionController::Base
  respond_to :json
  include ActionController::MimeResponds
end
