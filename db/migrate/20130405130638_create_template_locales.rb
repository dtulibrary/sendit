class CreateTemplateLocales < ActiveRecord::Migration
  def change
    create_table :template_locales do |t|
      t.string :code, :null => false

      t.timestamps
    end
    add_index :template_locales, :code, :unique => true
  end
end
