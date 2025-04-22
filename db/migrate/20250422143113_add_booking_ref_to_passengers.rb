class AddBookingRefToPassengers < ActiveRecord::Migration[8.0]
  def change
    add_reference :passengers, :booking, null: false, foreign_key: true
  end
end
