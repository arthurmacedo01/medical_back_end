module Api::V1::ImmunotherapiesHelper
  def format_left_zeros(value, n_digits)
    value_str = value.to_s
    zeros_to_add = n_digits - value_str.length

    value_str = "0" * zeros_to_add + value_str if zeros_to_add > 0

    value_str
  end
  def format_date_to_br(date)
    parts = date.to_s.split("-")
    day = parts[2]
    month = parts[1]
    year = parts[0]
    "#{day}/#{month}/#{year}"
  end
  def date_to_string(date)
    match_data = date.to_s.match(/(\d{4})-(\d{2})-(\d{2})/)
    yyyy, month, dd = match_data.captures
    months = %w[
      janeiro
      fevereiro
      março
      abril
      maio
      junho
      julho
      agosto
      setembro
      outubro
      novembro
      dezembro
    ]
    selected_month = months[month.to_i - 1]
    "#{dd} de #{selected_month} de #{yyyy}"
  end
end
