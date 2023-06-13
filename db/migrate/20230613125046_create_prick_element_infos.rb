class CreatePrickElementInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :prick_element_infos do |t|
      t.references :prick_test_info, null: false, foreign_key: true
      t.references :prick_group_info, null: false, foreign_key: true
      t.string :identifier
      t.string :label

      t.timestamps
    end
  end
end
