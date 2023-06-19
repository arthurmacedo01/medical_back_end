class CreatePrickMeasurements < ActiveRecord::Migration[7.0]
  def change
    create_table :prick_measurements do |t|
      t.decimal :first
      t.decimal :second
      t.decimal :mean
      t.string :result
      t.boolean :psd
      t.references :prick_element_info, null: false, foreign_key: true
      t.references :prick_form, null: false, foreign_key: true

      t.timestamps
    end
  end
end
