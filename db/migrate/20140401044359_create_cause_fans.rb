class CreateCauseFans < ActiveRecord::Migration
  def change
    create_table :cause_fans do |t|
      t.integer :user_id
      t.integer :cause_id
      t.string :status
      t.timestamps
    end
  end
end
