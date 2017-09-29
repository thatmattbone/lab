"""
Implementation of redis connection commands.

See: http://redis.io/commands#connection

Each command needs to be a callable.
"""


def ping():
    """
    See:
      - http://redis.io/commands/ping
    """
    return "PONG"


def echo(arg):
    """
    See:
      - http://redis.io/commands/echo
    """
    return arg
