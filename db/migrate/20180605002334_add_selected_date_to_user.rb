class AddSelectedDateToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :selected_date, :date
  end
end
