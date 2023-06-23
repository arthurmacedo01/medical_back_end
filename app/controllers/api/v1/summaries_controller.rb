class Api::V1::SummariesController < ApplicationController
  # GET /summaries/1
  def show
    patch_summary = PatchSummarizer.call(immunotherapy_patient)
    prick_summary = PrickSummarizer.call(immunotherapy_patient)
    render json: {
             patch_summary: patch_summary,
             prick_summary: prick_summary,
           },
           status: 200
  end

  private

  def immunotherapy_patient
    params.require(:id)
  end
end
