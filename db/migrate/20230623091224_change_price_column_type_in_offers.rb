class ChangePriceColumnTypeInOffers < ActiveRecord::Migration[7.0]
  def change
    change_column :offers, :price, :integer
  end
end
