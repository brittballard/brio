class CreateSonars < ActiveRecord::Migration
  def self.up
    create_table :sonars do |t|
      t.datetime :date
      t.string :company
      t.string :contact
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :sonars
  end
end
