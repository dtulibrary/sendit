class AddDisplayedToTemplate < ActiveRecord::Migration
  def change
    add_column :templates, :displayed, :boolean, :default => true
  end
end
