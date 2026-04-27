class CreateThings < ActiveRecord::Migration
  def self.up
    create_table :things do |t|
      t.timestamps
      t.string :name, :null => false
    end
  end

  def self.down
    drop_table :things
  end
end
