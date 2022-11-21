defmodule Birthday.Logic do
  def calculate_age(birthday) do
    age_data_type = System.get_env("data_type_response")
    array_date = convert_date_to_array(birthday)
    converted_date = convert_to_date(array_date)
    current_date = Date.utc_today()
    days_passed = Date.diff(current_date, converted_date)
    years_old = days_passed * (1 / 365)
    years_old |> trunc |> transform_data_type(age_data_type)
  end

  defp transform_data_type(data, data_type) when data_type == "string" do to_string(data) end
  defp transform_data_type(data, data_type) when data_type == "int" do data end

  defp convert_to_date(array_date) do
    year = String.to_integer(Enum.at(array_date, 2))
    month = String.to_integer(Enum.at(array_date, 1))
    day = String.to_integer(Enum.at(array_date, 0))
    {:ok, person_birthday} = Date.new(year, month, day)
    person_birthday
  end

  defp convert_date_to_array(date) do
      date |>  String.split("-")
  end
end
