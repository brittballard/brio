class RenameBirthdayColumn < ActiveRecord::Migration
  def self.up
    rename_column :users, :birthday, :birthday_date
  end

  def self.down
    rename_column :users, :birthday_date, :birthday
  end
end
