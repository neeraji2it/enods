class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      ## Token authenticatable
      t.string :authentication_token

      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :gender
      t.boolean :agree_terms
      t.string :provider
      t.string :uid
      t.string :token
      t.string :secret
      t.text :details
      t.string :role
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.string :image
      t.string :business_name
      t.string :website_url
      t.text :business_address
      t.string :city
      t.string :zip
      t.string :country
      t.string :state
      t.string :phone
      t.string :paypal_id
      t.date :date_of_birth
      t.text :other_info
      t.string :active
      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end
end
