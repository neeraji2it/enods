class AddTokenToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :sender_id, :integer
    add_column :users, :invitation_id, :integer
    change_column :users, :date_of_birth, :date
    remove_column :invitations, :user_id
  end
end
