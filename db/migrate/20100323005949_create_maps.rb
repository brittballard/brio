class CreateMaps < ActiveRecord::Migration
  def self.up
    create_table :maps do |t|
      t.timestamps
      t.string(:title, :limit => 50, :null => false)
      t.references(:event, :null => false)
    end
  end

  def self.down
    drop_table :maps
  end
end
