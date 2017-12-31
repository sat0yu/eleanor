class CreateSpeeches < ActiveRecord::Migration[5.1]
  def change
    create_table :speeches do |t|
      t.integer :script_id
      t.string  :url
      t.timestamps
    end
    add_index :speeches, :script_id
  end
end
