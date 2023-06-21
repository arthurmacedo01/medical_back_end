class AddOthersToImmunotherapies < ActiveRecord::Migration[7.0]
  def change
    add_column :immunotherapies, :others, :string, default: ""
  end
end
