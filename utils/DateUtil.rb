require 'date'

class DateUtil
  def self.get_current_date_plus_minute(number)
    today = DateTime.now
    time = "#{today.year}-#{today.month}-#{today.day} #{today.hour}:#{today.min + number.to_i}:#{today.sec}"
  end
end
