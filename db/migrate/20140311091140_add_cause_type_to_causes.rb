class AddCauseTypeToCauses < ActiveRecord::Migration
  def change
    add_column :causes, :cause_type, :string
  end
end
