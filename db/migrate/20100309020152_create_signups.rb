class CreateSignups < ActiveRecord::Migration
  def self.up
    create_table :signups do |t|
      t.int :user_id
      t.int :event_id
      t.string :signup_state
      t.boolean :accepted_terms
      t.int :payment_id

      t.timestamps
    end
  end

  def self.down
    drop_table :signups
  end
end
