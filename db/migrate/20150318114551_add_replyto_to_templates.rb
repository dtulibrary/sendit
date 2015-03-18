class AddReplytoToTemplates < ActiveRecord::Migration
  def change
    change_table :templates do |t|
      t.text :reply_to
    end
  end
end
