class Api::V1::ImmunotherapiesController < ApplicationController
  before_action :set_immunotherapy, only: %i[show update destroy]
  skip_before_action :verify_authenticity_token

  # GET /immunotherapies
  def index
    @immunotherapies = Immunotherapy.all

    render json: @immunotherapies
  end

  # GET /immunotherapies/1
  def show
    render json: @immunotherapy
  end

  # POST /immunotherapies
  def create
    @immunotherapy = Immunotherapy.new(immunotherapy_params)

    if @immunotherapy.save
      render json: @immunotherapy, status: 200
    else
      render json: @immunotherapy, status: 500
    end
  end

  # PATCH/PUT /immunotherapies/1
  def update
    if @immunotherapy.update(immunotherapy_params)
      render json: @immunotherapy
    else
      render json: @immunotherapy, status: 500
    end
  end

  # DELETE /immunotherapies/1
  def destroy
    if @immunotherapy.destroy
      render json: @immunotherapy, status: 200
    else
      render json: @immunotherapy, status: 500
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_immunotherapy
    @immunotherapy = Immunotherapy.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def immunotherapy_params
    params.require(:immunotherapy).permit(
      patient_id:,
      origin:,
      ige_total:,
      ige_specific:,
      eosinofilos_perc:,
      eosinofilos_mm:,
      prick_summary:,
      patch_summary:,
      primary_diagnosis:,
      secundary_diagnosis:,
      immunotheray_composition:,
      dilution_volume:,
      sublingual_drops:,
      city:,
      signature_date:,
    )
  end
end
