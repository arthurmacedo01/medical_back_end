class AddRequesterToPatchForm < ActiveRecord::Migration[7.0]
  def change
    add_column :patch_forms, :requester, :string
  end
end
