class CreatePrickGroupInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :prick_group_infos do |t|
      t.string :group_name
      t.timestamps
    end
  end
end
