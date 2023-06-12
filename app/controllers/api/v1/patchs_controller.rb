class Api::V1::PatchsController < ApplicationController
  before_action :set_patch_form, only: %i[show update destroy]
  skip_before_action :verify_authenticity_token

  # GET /patchs/1
  def show
    render json:
             PatchMeasurement
               .select(
                 "patch_measurements.*,patch_sensitizer_infos.label,patch_test_infos.identifier",
               )
               .joins(patch_sensitizer_info: :patch_test_info)
               .where(patch_form_id: @patch_form.id)
  end

  # POST /patchs
  def create
    @patch_form = PatchForm.new(patch_form_params)

    ActiveRecord::Base.transaction do
      @patch_form.save!
      patch_measurements_params(@patch_form).each do |patch_measurements_param|
        patch_measurement = PatchMeasurement.new(patch_measurements_param)
        patch_measurement.save!
      end
    end
    render json:
             PatchForm
               .select("patch_forms.*,patients.name,patients.birthday")
               .joins(:patient)
               .find(@patch_form.id),
           status: 200
  rescue ActiveRecord::RecordInvalid => exception
    # do something with exception here
    render json: {}, status: 500
  end

  # PATCH/PUT /patchs/1
  def update
    ActiveRecord::Base.transaction do
      @patch_form.update(patch_form_params)
      PatchMeasurement.where(patch_form_id: @patch_form).destroy_all
      patch_measurements_params(@patch_form).each do |patch_measurements_param|
        patch_measurement = PatchMeasurement.new(patch_measurements_param)
        patch_measurement.save!
      end
    end
  rescue ActiveRecord::RecordInvalid => exception
    # do something with exception here
    render json: {}, status: 500
  end

  # DELETE /patchs/1
  def destroy
    ActiveRecord::Base.transaction do
      PatchMeasurement.where(patch_form_id: @patch_form).destroy_all
      @patch_form.destroy
    end
    render json: @patch_form, status: 200
  rescue ActiveRecord::RecordInvalid => exception
    # do something with exception here
    render json: {}, status: 500
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_patch_form
    @patch_form = PatchForm.find(params[:id])
  end

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
      params[:patch_measurements].each do |a|
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
