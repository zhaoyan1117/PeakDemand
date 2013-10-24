class CreateDemands < ActiveRecord::Migration
  def change
    create_table :demands do |t|

			t.date :start_at, :null => false
			t.date :end_at, :null => false
			t.string :intensity, :null => false
			t.text :description

			t.integer :consumer_id, :null => false
			t.integer :resource_id, :null => false

      t.timestamps

    end
  end
end
