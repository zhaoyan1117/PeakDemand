class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :title
      t.text :body
      t.date :created_at
      t.integer :creator_id, :null => false

      t.timestamps
    end

    add_index :announcements, :creator_id
  end
end
