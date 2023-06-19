class ChangeAccepted < ActiveRecord::Migration[7.0]
  def change
    change_column :reservations, :accepted, :boolean, default: false
  end
end
