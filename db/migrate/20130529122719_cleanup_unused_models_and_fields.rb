class CleanupUnusedModelsAndFields < ActiveRecord::Migration
  def up
    drop_table :active_admin_comments
    drop_table :template_formats
    drop_table :template_locales
    drop_table :template_types
    drop_table :users

    remove_column :templates, :template_type_id
    remove_column :templates, :template_format_id
    remove_column :templates, :template_locale_id
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
