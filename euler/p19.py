"""
cheating on p19
"""
import datetime


if __name__ == "__main__":
    start_date = datetime.date(day=1, month=1, year=1901)
    end_date = datetime.date(day=31, month=12, year=2000)

    sundays_on_first_day_of_month = 0

    current_date = start_date
    while current_date <= end_date:

        if current_date.day == 1 and current_date.weekday() == 6:
            sundays_on_first_day_of_month += 1

        current_date += datetime.timedelta(days=1)

    print sundays_on_first_day_of_month
