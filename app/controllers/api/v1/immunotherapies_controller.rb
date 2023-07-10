class Api::V1::ImmunotherapiesController < ApplicationController
  before_action :set_immunotherapy, only: %i[show update destroy]
  before_action :set_pdf_manage, only: %i[create show update]
  before_action :authenticate_user!
  require "aws-sdk-core"

  # # Delete the temporary file after the action has completed
  # after_action :delete_temp_pdf, only: [:show]

  # GET /immunotherapies
  def index
    @immunotherapies = immunotherapies_with_patients.reverse
    render json: @immunotherapies
  end

  # GET /immunotherapies/1
  def show
    @temp_pdf_path = nil
    respond_to do |format|
      format.html
      format.json { render json: @immunotherapy }
      format.pdf do
        @temp_pdf_path = @pdfManager.write(html2pdf)
        send_file @temp_pdf_path,
                  filename: "imunoterapia.pdf",
                  type: "application/pdf",
                  disposition: "attachment"
        @pdfManager.delay(run_at: 5.seconds.from_now).delete_file(
          @temp_pdf_path,
        )
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
    bucketManager = BucketManager.new
    bucketManager.write(html2pdf, "immunotherapies/#{@immunotherapy.id}.pdf")

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

  def set_pdf_manage
    @pdfManager = PdfManager.new
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

  def html2pdf
    html =
      render_to_string(
        template: "api/v1/immunotherapies/show",
        layout: "api/v1/layouts/one_a5_page",
        formats: [:html],
        locals: {
          immunotherapy: @immunotherapy,
        },
        encoding: "UTF-8", # Encoding
      )
    @pdfManager.html2pdf(html)
  end
end
