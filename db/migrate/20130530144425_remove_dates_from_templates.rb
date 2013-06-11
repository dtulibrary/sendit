class RemoveDatesFromTemplates < ActiveRecord::Migration
  def up
    remove_column :templates, :valid_from
    remove_column :templates, :valid_until
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
