class Api::V1::PatchController < ApplicationController
  skip_before_action :verify_authenticity_token

  # POST /patients
  def create
    @patch_form = PatchForm.new(patch_form_params)

    ActiveRecord::Base.transaction do
      @patch_form.save!
      patch_measurements_params(@patch_form).each do |patch_measurements_param|
        patch_measurement = PatchMeasurement.new(patch_measurements_param)
        patch_measurement.save!
      end
    end
    render json: @patch_form, status: 200
  rescue ActiveRecord::RecordInvalid => exception
    # do something with exception here
    render json: {}, status: 500
  end

  private

  # Only allow a list of trusted parameters through.
  def patch_form_params
    params.require(:patch_form).permit(
      :patient_id,
      :clinic,
      :application,
      :first_measurement,
      :second_measurement,
      :city,
      :signature_date,
      :requester,
    )
  end

  def patch_measurements_params(patch_form)
    parameters_input =
      params
        .require(:patch_measurements)
        .each do |a|
          a.permit(:patient_id, :first, :second, :patch_sensitizer_info_label)
        end

    parameters_input.map do |parameter_input|
      {
        first: parameter_input["first"],
        second: parameter_input["second"],
        patch_sensitizer_info_id:
          PatchSensitizerInfo.find_by(
            label: parameter_input["patch_sensitizer_info_label"],
          ).id,
        patch_form_id: patch_form.id,
      }
    end
  end
end
