class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :code
      t.text :body
      t.references :template_type
      t.references :template_format
      t.references :template_locale
      t.datetime :valid_from
      t.datetime :valid_until

      t.timestamps
    end
    add_index :templates, :template_type_id
    add_index :templates, :template_format_id
    add_index :templates, :template_locale_id
    add_index :templates, :code
  end
end
