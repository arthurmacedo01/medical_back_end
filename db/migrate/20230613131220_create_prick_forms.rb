class CreatePrickForms < ActiveRecord::Migration[7.0]
  def change
    create_table :prick_forms do |t|
      t.references :patient, null: false, foreign_key: true
      t.string :clinic
      t.string :city
      t.string :puncture_time
      t.string :reading_time
      t.date :signature_date
      t.text :comments
      t.decimal :positive_control1
      t.decimal :negative_control1
      t.decimal :positive_control2
      t.decimal :negative_control2
      t.decimal :mean_positive_control
      t.decimal :mean_negative_control
      t.string :requester
      t.timestamps
    end
  end
end
