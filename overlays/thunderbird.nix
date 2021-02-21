final: prev:
{
  # I don't use the calendar.
  thunderbird = prev.thunderbird.override { enableCalendar = false; };
}

