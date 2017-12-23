class AlterPieceEnPassant < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :en_passant, :boolean, default: nil
  end
end
