defmodule Weatherise.WeatherInfo do
  import SweetXml
  require Logger

  @base_url Application.get_env(:weatherise, :base_url)

  def fetch(airport_id) do
    Logger.info "Fetching airport #{airport_id} region weather info"
    weather_info_url(airport_id)
    |> HTTPoison.get
    |> handle_response
  end

  defp weather_info_url(airport_id) do
    "#{@base_url}/xml/current_obs/#{airport_id}.xml"
  end

  defp handle_response({ :ok, %{ status_code: 200, body: body } }) do
    Logger.info "Successful response"
    body
    |> to_map
    |> to_success_touple
  end

  defp handle_response({ _, %{ status_code: status, body: body } }) do
    Logger.error "Error #{status} returned"
    { :error, "Unable to retrieve weather info" }
  end

  defp to_map(body) do
    body |> xmap(
      location:  ~x"//location/text()",
      station:   ~x"//station_id/text()",
      latitude:  ~x"//latitude/text()",
      longitude: ~x"//longitude/text()",
      observation: ~x"//observation_time_rfc822/text()",
      weather: ~x"//weather/text()",
      temperature: ~x"//temp_c/text()"
    )
  end

  defp to_success_touple(converted_response) do
    { :ok, converted_response }
  end
end
