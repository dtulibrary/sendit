class AddActiveFlagToTemplates < ActiveRecord::Migration
  def change
    add_column :templates, :active, :boolean, :default => false
  end
end
