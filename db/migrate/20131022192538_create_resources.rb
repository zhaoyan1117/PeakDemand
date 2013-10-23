class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|

    	t.string :name, :null => false
    	t.text :description

    	t.date :start_at
    	t.date :end_at

    	t.integer :creator_id, :null => false

      t.timestamps
    end
  end
end
