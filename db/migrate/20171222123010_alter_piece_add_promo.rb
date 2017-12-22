class AlterPieceAddPromo < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :promo, :string, default: nil
  end
end
