class CreateTemplateFormats < ActiveRecord::Migration
  def change
    create_table :template_formats do |t|
      t.string :code, :null => false

      t.timestamps
    end
    add_index :template_formats, :code, :unique => true
  end
end
