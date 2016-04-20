class AddEfficiencyToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :efficiency, :decimal, precision: 5, default: 0.0
  end
end
