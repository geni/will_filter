class CreateFoos < ActiveRecord::Migration[8.0]
  def change
    create_table :foos do |t|
      t.timestamps
      t.string :name, :null => false
    end
  end
end
