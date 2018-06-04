class AddRecentSearchToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :recent_search, :text
  end
end
