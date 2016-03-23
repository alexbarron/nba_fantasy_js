class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :position
      t.integer :score, default: 0
      t.integer :salary, default: 525093

      t.timestamps null: false
    end
  end
end
