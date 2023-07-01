class Api::V1::AllergensController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  
  # GET /allergens
  def index
    @allergens = allergens_with_patients.to_json
    render json: @allergens
  end

  private

  def allergens_with_patients
    {
      patch_forms:
        PatchForm.select("patch_forms.*,patients.name,patients.birthday").joins(
          :patient,
        ),
      prick_forms:
        PrickForm.select("prick_forms.*,patients.name,patients.birthday").joins(
          :patient,
        ),
    }
  end
end
