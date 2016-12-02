class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks do |t|
      t.datetime :on
      t.text :data

      t.timestamps
    end
  end
end
