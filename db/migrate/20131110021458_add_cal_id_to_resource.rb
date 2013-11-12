class AddCalIdToResource < ActiveRecord::Migration
  def change
    add_column :resources, :cal_id, :string
  end
end
