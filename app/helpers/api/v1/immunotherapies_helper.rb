module ImmunotherapiesHelper
  def format_left_zeros(value, n_digits)
    value_str = value.to_s
    zeros_to_add = n_digits - value_str.length
  
    if zeros_to_add > 0
      value_str = "0" * zeros_to_add + value_str
    end
  
    value_str
  end
  def format_date_to_br(date)
    parts = date.to_s.split("-")
    day = parts[2]
    month = parts[1]
    year = parts[0]
    "#{day}/#{month}/#{year}"
  end
  def date_br_to_string(date)
    date_array = date.split("/")
    yyyy = date_array[0]
    month_idx = date_array[1].to_i - 1
    dd = date_array[2]
    months = [
      "janeiro",
      "fevereiro",
      "março",
      "abril",
      "maio",
      "junho",
      "julho",
      "agosto",
      "setembro",
      "outubro",
      "novembro",
      "dezembro"
    ]
    selected_month = months[month_idx]
    "#{dd} de #{selected_month} de #{yyyy}"
  end
  
end
