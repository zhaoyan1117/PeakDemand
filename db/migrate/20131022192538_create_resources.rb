class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|

    	t.string :name, :null => false
    	t.text :description

    	t.date :start_at, :null => false
    	t.date :end_at, :null => false

    	t.integer :provider_id, :null => false

      t.timestamps
    end
  end
end
