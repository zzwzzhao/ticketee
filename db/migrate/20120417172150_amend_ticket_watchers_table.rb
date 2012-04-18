class AmendTicketWatchersTable < ActiveRecord::Migration
  def change
    drop_table :ticket_wathcers

    create_table :ticket_watchers, :id => false do |t|
      t.integer :user_id, :ticket_id
    end


  end
end
