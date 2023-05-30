class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients do |t|
      t.string :name
      t.date :birthday
      t.string :cpf
      t.string :gender
      t.string :contact
      t.string :responsable_name
      t.string :responsable_degree
      t.timestamps
    end
  end
end
