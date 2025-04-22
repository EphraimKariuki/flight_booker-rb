class AddArrivalAirportRefToFlights < ActiveRecord::Migration[8.0]
  def change
    add_reference :flights, :arrival_airport, null: false, foreign_key: { to_table: :airports }, index: true
  end
end
