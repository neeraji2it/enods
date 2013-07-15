class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :email
      t.integer :user_id
      t.string :status
      t.timestamps
    end
  end
end
