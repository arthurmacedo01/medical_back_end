class CreatePatchTestInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :patch_test_infos do |t|
      t.string :identifier
      t.string :title
      t.boolean :initial_show
      t.text :description
      t.text :application
      t.text :citation

      t.timestamps
    end
  end
end
