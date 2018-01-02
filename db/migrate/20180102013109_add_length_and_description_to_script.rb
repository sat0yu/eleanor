class AddLengthAndDescriptionToScript < ActiveRecord::Migration[5.1]
  def change
    add_column :scripts, :length, :integer
    add_column :scripts, :description, :string
  end
end
