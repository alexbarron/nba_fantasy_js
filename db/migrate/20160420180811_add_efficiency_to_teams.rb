class AddEfficiencyToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :efficiency, :decimal, default: 0.0
  end
end
