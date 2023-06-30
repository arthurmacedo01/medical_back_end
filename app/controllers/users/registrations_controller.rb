class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  before_action :authenticate_user!, only: %i[new create]

  def create
    if user_signed_in?
      super
    else
      render json: {
               status: {
                 code: 422,
                 message: "You must be logged in to create a new user.",
               },
             },
             status: :unprocessable_entity
    end
  end

  private

  def respond_with(resource, _opts = {})
    if request.method == "POST" && resource.persisted?
      render json: {
               status: {
                 code: 200,
                 message: "Signed up sucessfully.",
               },
               data:
                 UserSerializer.new(resource).serializable_hash[:data][
                   :attributes
                 ],
             },
             status: :ok
    elsif request.method == "DELETE"
      render json: {
               status: {
                 code: 200,
                 message: "Account deleted successfully.",
               },
             },
             status: :ok
    else
      render json: {
               status: {
                 code: 422,
                 message:
                   "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}",
               },
             },
             status: :unprocessable_entity
    end
  end
end
