class UncreateSonars < ActiveRecord::Migration
  def self.up
    drop_table :sonars
  end

  def self.down
    create_table :sonars do |t|
      t.datetime :date
      t.string :company
      t.string :contact
      t.string :description

      t.timestamps
    end
  end
end
