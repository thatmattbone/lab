"""
Implementation of redis connection commands.

See: http://redis.io/commands#connection

Each command needs to be a callable.
"""


def dbsize(db):
    """
    See:
      - http://redis.io/commands/dbsize
    """
    return len(db)


def flushdb(db):
    """
    See:
      - http://redis.io/commands/flushdb
    """
    for key in list(db.keys()):
        del db[key]