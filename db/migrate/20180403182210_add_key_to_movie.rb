class AddKeyToMovie < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :key, :string
  end
end
