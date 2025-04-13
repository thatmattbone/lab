
class MyException(Exception):
    pass


def my_chained_exception():
    try:
        raise ValueError()
    except ValueError as e:
        raise MyException from e

if __name__ == '__main__':
    my_chained_exception()
