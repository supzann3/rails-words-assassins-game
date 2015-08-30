class AddPlayerIdToReceivedEmails < ActiveRecord::Migration
  def change
    add_column :received_emails, :player_id, :integer
  end
end
