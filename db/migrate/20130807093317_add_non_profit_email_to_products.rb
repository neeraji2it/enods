class AddNonProfitEmailToProducts < ActiveRecord::Migration
  def change
    add_column :products, :non_profit_email, :string
    add_column :products, :fair_trade, :string
  end
end
