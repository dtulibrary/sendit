class CreateSentEmails < ActiveRecord::Migration
  def change
    create_table :sent_emails do |t|
      t.references :template
      t.text :to_address
      t.text :data
      t.text :message

      t.timestamps
    end
    add_index :sent_emails, :template_id
  end
end
