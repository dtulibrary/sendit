class AddSubjectAndFromToTemplates < ActiveRecord::Migration
  def change
    add_column :templates, :subject, :text
    add_column :templates, :from,    :text
  end
end
