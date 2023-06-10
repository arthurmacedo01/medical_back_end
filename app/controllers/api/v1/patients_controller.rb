class Api::V1::PatientsController < ApplicationController
  before_action :set_patient, only: %i[show update destroy]
  skip_before_action :verify_authenticity_token

  # GET /patients
  def index
    @patients = Patient.all

    render json: @patients
  end

  # GET /patients/1
  def show
    render json: @patient
  end

  # POST /patients
  def create
    @patient = Patient.new(patient_params)

    if @patient.save
      render json: @patient, status: 200
    else
      render json: @patient, status: 500
    end
  end

  # PATCH/PUT /patients/1
  def update
    if @patient.update(patient_params)
      render json: @patient
    else
      render json: @patient, status: 500
    end
  end

  # DELETE /patients/1
  def destroy
    ActiveRecord::Base.transaction do
      patch_form_ids = PatchForm.where(patient_id: @patient.id).pluck(:id)
      PatchMeasurement.where(patch_form_id: patch_form_ids).destroy_all
      PatchForm.where(patient_id: @patient.id).destroy_all
      Immunotherapy.where(patient_id: @patient.id).destroy_all
      @patient.destroy
    end
    render json: @patient, status: 200
  rescue ActiveRecord::RecordInvalid => exception
    # do something with exception here
    render json: @patient, status: 500
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_patient
    @patient = Patient.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def patient_params
    params.require(:patient).permit(
      :name,
      :birthday,
      :cpf,
      :gender,
      :contact,
      :responsable_name,
      :responsable_degree,
      :origin,
      :obs,
    )
  end
end
