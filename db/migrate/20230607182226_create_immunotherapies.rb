class CreateImmunotherapies < ActiveRecord::Migration[7.0]
  def change
    create_table :immunotherapies do |t|
      t.references :patient, null: false, foreign_key: true
      t.string :ige_total, default: ""
      t.string :ige_specific, default: ""
      t.string :eosinofilos_perc, default: ""
      t.string :eosinofilos_mm, default: ""
      t.string :prick_summary, default: ""
      t.string :patch_summary, default: ""
      t.text :primary_diagnosis, default: ""
      t.text :secondary_diagnosis, default: ""
      t.text :immunotheray_composition, default: ""
      t.text :dilution_volume, default: ""
      t.integer :sublingual_drops, default: 0
      t.string :city, default: ""
      t.date :signature_date, default: "1000-01-01"

      t.timestamps
    end
  end
end
