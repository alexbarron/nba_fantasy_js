class AddStarterToRosterSpots < ActiveRecord::Migration
  def change
    add_column :roster_spots, :starter, :boolean, default: false
  end
end
