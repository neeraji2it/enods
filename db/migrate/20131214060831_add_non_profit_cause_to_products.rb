class AddNonProfitCauseToProducts < ActiveRecord::Migration
  def change
    add_column :products, :non_profit_cause, :string
    add_column :products, :agree_terms, :boolean
  end
end
