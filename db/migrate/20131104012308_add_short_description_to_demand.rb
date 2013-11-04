class AddShortDescriptionToDemand < ActiveRecord::Migration
  def change
    add_column :demands, :short_description, :string
  end
end
