class CreateFlights < ActiveRecord::Migration[8.0]
  def change
    create_table :flights do |t|
      t.datetime :start_date
      t.integer :duration

      t.timestamps
    end
  end
end
