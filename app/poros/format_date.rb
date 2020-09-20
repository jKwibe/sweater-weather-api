class FormatDate
  def self.day(unix)
    Time.at(unix).strftime('%A')
  end

  def self.full_date_time(unix)
    Time.at(unix).strftime('%l:%M %P,  %b %d')
  end

  def self.full_time(unix)
    Time.at(unix).strftime('%l:%M %P')
  end

  def self.short_time(unix)
    Time.at(unix).strftime('%l %P')
  end
end
