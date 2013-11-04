class AddShortDescriptionToResource < ActiveRecord::Migration
  def change
    add_column :resources, :short_description, :string
  end
end
