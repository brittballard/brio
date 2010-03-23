class CreateMapDataPoints < ActiveRecord::Migration
  def self.up
    create_table :map_data_points do |t|
      t.timestamps
      t.lat(:string, :null => false, :limit => 50)
      t.lng(:string, :null => false, :limit => 50)
      t.string(:type, :limit => 20)
      t.references(:map, :null => false)
    end
  end

  def self.down
    drop_table :map_data_points
  end
end
