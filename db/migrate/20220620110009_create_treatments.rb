class CreateTreatments < ActiveRecord::Migration[7.0]
  def change
    create_table :treatments do |t|
      t.date :date
      t.text :description
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :treatments, [:client_id, :created_at]

  end
end
