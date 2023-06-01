class AddOriginToPatients < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :origin, :string
  end
end
