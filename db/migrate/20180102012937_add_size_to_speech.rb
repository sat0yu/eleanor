class AddSizeToSpeech < ActiveRecord::Migration[5.1]
  def change
    add_column :speeches, :size, :integer
  end
end
