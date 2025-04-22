class FlightsController < ApplicationController
  def index
    @airports = Airport.all
    @airport_options = @airports.map { |airport| [ airport.name, airport.id ] }

    @dates = Flight.pluck(:start_date).map { |date| date.to_date }.uniq
    @date_options = @dates.map { |date| [ date.strftime("%B %d, %Y"), date ] }


    if params[:departure_airport_id].present? && params[:arrival_airport_id].present? && params[:date].present?
      @matching_flights = Flight.where(
        departure_airport_id: params[:departure_airport_id],
        arrival_airport_id: params[:arrival_airport_id],
        start_date: params[:date].to_date.beginning_of_day..params[:date].to_date.end_of_day
      )

      @num_passengers = params[:num_passengers]
    end
  end
end
