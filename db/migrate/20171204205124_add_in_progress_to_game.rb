class AddInProgressToGame < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :in_progress, :boolean
  end
end
