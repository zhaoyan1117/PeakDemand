class AddEventIdToDemands < ActiveRecord::Migration
  def change
    add_column :demands, :event_id, :string
  end
end
