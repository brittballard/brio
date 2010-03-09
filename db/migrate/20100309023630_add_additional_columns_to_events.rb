class AddAdditionalColumnsToEvents < ActiveRecord::Migration
  def self.up
    add_column(:events, :registration_fee, :decimal, :percision => 2, :null => false)
    add_column(:events, :description, :text, :null => false)
    add_column(:events, :max_participants, :integer)
    add_column(:events, :disclaimer, :text, :null => false)
    add_column(:events, :address_line_1, :string, :null => false)
    add_column(:events, :address_line_2, :string)
    add_column(:events, :city, :string, :limit => 50, :null => false)
    add_column(:events, :state, :string, :limit => 2, :null => false)
    add_column(:events, :postal_code, :string, :limit => 10, :null => false)
    add_column(:events, :parent_id, :integer)
    add_column(:events, :minimum_age_to_register, :integer)
    add_column(:events, :minimum_age_to_participate, :integer)
    add_column(:events, :time_zone, :string, :limit => 40, :null => false)
    add_column(:events, :latitude, :string, :limit => 40)
    add_column(:events, :longitude, :string, :limit => 40)
  end

  def self.down
    remove_column(:events, :registration_fee, :description, :max_participants, :disclaimer, :address_line_1, :address_line_2, :city, :state,
      :postal_code, :parent_id, :minimum_age_to_register, :minimum_age_to_participate, :time_zone, :latitude, :longitude)
  end
end
