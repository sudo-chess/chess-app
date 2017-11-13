class AddTypeToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :type, :string
  end
end
