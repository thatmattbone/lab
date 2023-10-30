from datetime import datetime
from pprint import pp

def to_date(year, day_of_year):
    the_date = datetime.strptime(f'{year} {day_of_year}', '%Y %j')
    return the_date

if __name__ == '__main__':

    for year in (2023, 2024):

        dates = {}
        for i in range(365):
            the_date = to_date(year, i + 1)

            month = the_date.month

            if month not in dates:
                dates[month] = {
                    'start': i + 1,
                }

                if month - 1 in dates:
                    dates[month - 1]['end'] = i

        pp(dates)
        print('*' * 25)
