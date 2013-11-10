class AddCalIdToResource < ActiveRecord::Migration
  def change
    add_column :resources, :light_cal_id, :string
    add_column :resources, :moderate_cal_id, :string
    add_column :resources, :heavy_cal_id, :string
    add_column :resources, :occupy_cal_id, :string
  end
end
