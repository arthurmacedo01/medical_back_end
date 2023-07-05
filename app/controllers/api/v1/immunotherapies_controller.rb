class Api::V1::ImmunotherapiesController < ApplicationController
  before_action :set_immunotherapy, only: %i[show update destroy]
  # before_action :authenticate_user!
  helper ImmunotherapiesHelper


  # GET /immunotherapies
  def index
    @immunotherapies = immunotherapies_with_patients.reverse
    render json: @immunotherapies
  end

  # GET /immunotherapies/1
  def show
    html =
      render_to_string(
        template: "api/v1/immunotherapies/show",
        layout: "api/v1/layouts/application",
        formats: [:html],
        locals: {
          immunotherapy: @immunotherapy,
        },
        encoding: "UTF-8", # Encoding
      )

    url = ENV["RAILS_SERVE_STATIC_FILES"]
    base_url = url.match(%r{^https?://[^/]+}).to_s
    absolute_html = Grover::HTMLPreprocessor.process html, base_url+"/", "http"
    grover = Grover.new(absolute_html, format: 'A5')
    pdf_data = grover.to_pdf

    # # Save the PDF data to a temporary file
    temp_pdf_path = Rails.root.join("tmp", "temp_pdf.pdf")
    File.open(temp_pdf_path, "wb") { |file| file << pdf_data }

    respond_to do |format|
      format.html
      format.json { render json: @immunotherapy }
      format.pdf do
        send_file temp_pdf_path,
                  filename: "your_filename.pdf",
                  type: "application/pdf",
                  disposition: "attachment"
      end
    end
  end

  # POST /immunotherapies
  def create
    @immunotherapy = Immunotherapy.new(immunotherapy_params)

    @immunotherapy.patch_summary =
      PatchSummarizer.call(@immunotherapy.patient_id)
    @immunotherapy.prick_summary =
      PrickSummarizer.call(@immunotherapy.patient_id)

    if @immunotherapy.save
      render json:
               immunotherapies_with_patients.find(@immunotherapy.id).to_json,
             status: 200
    else
      render json: @immunotherapy, status: 500
    end
  end

  # PATCH/PUT /immunotherapies/1
  def update
    if @immunotherapy.update(immunotherapy_params)
      render json:
               immunotherapies_with_patients.find(@immunotherapy.id).to_json,
             status: 200
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
      :patient_id,
      :ige_total,
      :ige_specific,
      :eosinofilos_perc,
      :eosinofilos_mm,
      :others,
      :prick_summary,
      :patch_summary,
      :primary_diagnosis,
      :secondary_diagnosis,
      :immunotheray_composition,
      :dilution_volume,
      :sublingual_drops,
      :city,
      :signature_date,
    )
  end

  def immunotherapies_with_patients
    Immunotherapy.select(
      "immunotherapies.*,patients.name,patients.birthday,patients.cpf,patients.gender,patients.contact,patients.responsable_name,patients.responsable_degree,patients.origin",
    ).joins(:patient)
  end
end
