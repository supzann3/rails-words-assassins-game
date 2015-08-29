class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :email
      t.string :word
      t.boolean :alive?
      t.integer :kills 
      t.integer :victim_id

      t.timestamps null: false
    end
  end
end
