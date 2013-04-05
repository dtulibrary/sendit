class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :username,           :null => false, :default => ""

      t.timestamps
    end

    add_index :users, :username,             :unique => true
  end
end
