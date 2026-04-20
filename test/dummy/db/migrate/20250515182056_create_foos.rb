class CreateFoos < ActiveRecord::Migration
  def self.up
    create_table :foos do |t|
      t.timestamps
      t.string :name, :null => false
    end
  end

  def self.down
    drop_table :foos
  end
end
