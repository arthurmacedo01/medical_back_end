class PrickSummarizer
  def self.call(patient_id)
    new().call(patient_id)
  end

  def call(patient_id)
    prick_array_result = []
    prick_form = PrickForm.where(patient_id: patient_id).last

    unless prick_form.nil?
      prick_measurements =
        PrickMeasurement.includes(:prick_element_info).where(
          prick_form_id: prick_form.id,
        )

      prick_measurements.each do |e|
        if (e.mean >= 3)
          prick_array_result.push(
            e.prick_element_info.identifier + " " +
              (e.mean == e.mean.to_i ? e.mean.to_i.to_s : e.mean.to_s),
          )
        end
      end
    end
    return arrayToText(prick_array_result)
  end

  private

  def arrayToText(array)
    text = ""
    array.each_with_index do |element, index|
      if (index + 1 === array.length)
        text = text + element
      elsif (index + 1 === array.length - 1)
        text = text + element + " e "
      else
        text = text + element + ", "
      end
    end
    return text
  end
end
