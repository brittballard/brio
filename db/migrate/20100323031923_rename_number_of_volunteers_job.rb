class RenameNumberOfVolunteersJob < ActiveRecord::Migration
  def self.up
    rename_column(:jobs, :number_of_volnteers, :number_of_volunteers)
  end

  def self.down
    rename_column(:jobs, :number_of_volunteers , :number_of_volnteers)
  end
end
