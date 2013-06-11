class AddPlainTextAndExampleDataToTemplate < ActiveRecord::Migration
  def change
    rename_column :templates, :body, :html
    add_column :templates, :plain, :text
    add_column :templates, :example, :text
  end
end
