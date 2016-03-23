class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :score, default: 0
      t.integer :salary_remaining, default: 70000000
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
