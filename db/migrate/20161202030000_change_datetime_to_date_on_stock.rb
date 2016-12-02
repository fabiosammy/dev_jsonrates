class ChangeDatetimeToDateOnStock < ActiveRecord::Migration[5.0]
  def up
    change_column :stocks, :on, :date
  end

  def down
    change_column :stocks, :on, :datetime
  end
end
