class CreateImmunotherapies < ActiveRecord::Migration[7.0]
  def change
    create_table :immunotherapies do |t|
      t.references :patient, null: false, foreign_key: true
      t.string :origin
      t.string :ige_total
      t.string :ige_specific
      t.string :eosinofilos_perc
      t.string :eosinofilos_mm
      t.string :prick_summary
      t.string :patch_summary
      t.text :primary_diagnosis
      t.text :secundary_diagnosis
      t.text :immunotheray_composition
      t.text :dilution_volume
      t.integer :sublingual_drops
      t.string :city
      t.date :signature_date

      t.timestamps
    end
  end
end
