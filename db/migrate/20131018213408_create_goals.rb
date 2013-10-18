class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :user_id, :null => false
      t.string :title, :null => false
      t.text :body, :null => false
      t.boolean :private, :default => false
      t.boolean :completed, :default => false

      t.timestamps
    end
    add_index :goals, :user_id
  end
end
