class CreatePatchForms < ActiveRecord::Migration[7.0]
  def change
    create_table :patch_forms do |t|
      t.references :patient, null: false, foreign_key: true
      t.string :clinic
      t.date :application
      t.date :first_measurement
      t.date :second_measurement
      t.string :city
      t.date :signature_date

      t.timestamps
    end
  end
end
