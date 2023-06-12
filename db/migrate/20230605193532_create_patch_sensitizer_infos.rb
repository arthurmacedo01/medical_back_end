class CreatePatchSensitizerInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :patch_sensitizer_infos do |t|
      t.references :patch_test_info, null: false, foreign_key: true
      t.string :label
      t.string :name
      t.string :option_name
      t.text :description
      t.text :first_text
      t.text :second_text

      t.timestamps
    end
  end
end
