class Api::V1::PricksController < ApplicationController
  before_action :set_prick_form, only: %i[show update destroy]
  skip_before_action :verify_authenticity_token

  # GET /pricks/1
  def show
    render json:
             PrickMeasurement
               .select("prick_measurements.*,prick_element_infos.identifier")
               .joins(:prick_element_info)
               .where(prick_form_id: @prick_form.id)
  end

  # POST /pricks
  def create
    @prick_form = PrickForm.new(prick_form_params)

    puts @prick_form
    ActiveRecord::Base.transaction do
      @prick_form.save!
      prick_measurements_params(@prick_form).each do |prick_measurements_param|
        prick_measurement = PrickMeasurement.new(prick_measurements_param)
        prick_measurement.save!
      end
    end
    render json:
             PrickForm
               .select("prick_forms.*,patients.name,patients.birthday")
               .joins(:patient)
               .find(@prick_form.id),
           status: 200
  rescue ActiveRecord::RecordInvalid => exception
    # do something with exception here
    render json: {}, status: 500
  end

  # DELETE /pricks/1
  def destroy
    ActiveRecord::Base.transaction do
      PrickMeasurement.where(prick_form_id: @prick_form).destroy_all
      @prick_form.destroy
    end
    render json: @prick_form, status: 200
  rescue ActiveRecord::RecordInvalid => exception
    # do something with exception here
    render json: {}, status: 500
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_prick_form
    @prick_form = PrickForm.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def prick_form_params
    params.require(:prick_form).permit(
      :patient_id,
      :clinic,
      :city,
      :puncture_time,
      :reading_time,
      :signature_date,
      :requester,
      :comments,
      :positive_control1,
      :positive_control2,
      :negative_control1,
      :negative_control2,
      :mean_positive_control,
      :mean_negative_control,
    )
  end

  def prick_measurements_params(prick_form)
    parameters_input =
      params[:prick_measurements].each do |a|
        a.permit(
          :first,
          :second,
          :mean,
          :result,
          :psd,
          :prick_element_info_identifier,
        )
      end

    parameters_input.map do |parameter_input|
      {
        first: parameter_input["first"],
        second: parameter_input["second"],
        mean: parameter_input["mean"],
        result: parameter_input["result"],
        psd: parameter_input["psd"],
        prick_element_info_id:
          PrickElementInfo.find_by(
            identifier: parameter_input["prick_element_info_identifier"],
          ).id,
        prick_form_id: prick_form.id,
      }
    end
  end
end
