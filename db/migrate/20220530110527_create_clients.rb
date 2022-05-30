class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_num
      t.text :comment

      t.timestamps
    end
    add_index :clients, :last_name
  end
end
