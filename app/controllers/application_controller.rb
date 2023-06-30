class ApplicationController < ActionController::Base
  respond_to :json
  include ActionController::MimeResponds
  skip_before_action :verify_authenticity_token

end
