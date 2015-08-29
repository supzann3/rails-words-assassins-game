class CreateReceivedEmails < ActiveRecord::Migration
  def change
    create_table :received_emails do |t|
      t.string :from
      t.string :subject

      t.timestamps null: false
    end
  end
end
