class AddCcToTemplates < ActiveRecord::Migration
  def change
    change_table :templates do |t|
      t.text :cc
    end
  end
end
