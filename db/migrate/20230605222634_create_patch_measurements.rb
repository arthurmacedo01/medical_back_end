class CreatePatchMeasurements < ActiveRecord::Migration[7.0]
  def change
    create_table :patch_measurements do |t|
      t.string :first
      t.string :second
      t.string :result
      t.references :patch_sensitizer_info, null: false, foreign_key: true
      t.references :patch_form, null: false, foreign_key: true

      t.timestamps
    end
  end
end
