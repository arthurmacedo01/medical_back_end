class CreatePrickForms < ActiveRecord::Migration[7.0]
  def change
    create_table :prick_forms do |t|
      t.references :patient, null: false, foreign_key: true
      t.string :clinic
      t.string :city
      t.date :puncture_date
      t.date :signature_date
      t.text :comments
      t.decimal :positive_control
      t.decimal :negative_control
      t.decimal :mean_control

      t.timestamps
    end
  end
end
