class PatchSummarizer
  def self.call(patient_id)
    new().call(patient_id)
  end

  def call(patient_id)
    patch_array_result = []
    patch_form = PatchForm.where(patient_id: patient_id).last

    unless patch_form.nil?
      patch_measurements =
        PatchMeasurement.includes(
          patch_sensitizer_info: :patch_test_info,
        ).where(patch_form_id: patch_form.id)

      patch_test_ids =
        patch_measurements
          .map { |e| e.patch_sensitizer_info.patch_test_info.id }
          .uniq

      patch_test_ids.each do |test_id|
        patch_one_test_measurements =
          patch_measurements.filter do |e|
            e.patch_sensitizer_info.patch_test_info.id == test_id
          end

        patch_one_test_positive_measurements =
          patch_one_test_measurements.filter do |p|
            p.first != "-" || p.second != "-"
          end

        if (patch_one_test_positive_measurements.length > 0)
          patch_one_test_positive_measurements.each do |patch_one_test_positive_measurement|
            patch_array_result.push(
              patch_one_test_positive_measurement.patch_sensitizer_info.label +
                patch_one_test_positive_measurement.first + "/" +
                patch_one_test_positive_measurement.second,
            )
          end
        else
          patch_label =
            patch_one_test_measurements[
              0
            ].patch_sensitizer_info.label.match /\D+/
          patch_array_result.push(patch_label.to_s + "-")
        end
        puts patch_array_result
      end
    end
    return arrayToText(patch_array_result)
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
