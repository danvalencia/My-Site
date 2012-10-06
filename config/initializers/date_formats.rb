Time::DATE_FORMATS.merge!(
  :default => lambda { |time| time.strftime("%B #{time.day.ordinalize}, %Y") },
  :no_year => lambda { |time| time.strftime("%B #{time.day.ordinalize}") }
)