class AddNonProfitPercentageToProducts < ActiveRecord::Migration
  def change
    add_column :products, :non_profit_percentage, :integer
  end
end
