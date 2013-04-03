class CreateTemplateTypes < ActiveRecord::Migration
  def change
    create_table :template_types do |t|
      t.string :code

      t.timestamps
    end
  end
end
