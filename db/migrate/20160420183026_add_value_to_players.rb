class AddValueToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :value, :decimal, precision: 5, default: 0.00
  end
end
