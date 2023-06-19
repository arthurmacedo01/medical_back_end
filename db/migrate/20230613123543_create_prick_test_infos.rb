class CreatePrickTestInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :prick_test_infos do |t|
      t.string :title

      t.timestamps
    end
  end
end
