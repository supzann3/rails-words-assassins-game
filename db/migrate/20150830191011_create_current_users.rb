class CreateCurrentUsers < ActiveRecord::Migration
  def change
    create_table :current_users do |t|
      t.string :email

      t.timestamps null: false
    end
  end
end
