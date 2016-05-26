"""
Implementation of redis set commands.

See: http://redis.io/commands#set

Each command needs to be a callable.
"""


def sadd(db, key, *args):
    """
    See:
      - http://redis.io/commands/sadd
    """
    value = db.setdefault(key, set())
    for arg in args:
        value.add(arg)

    return len(value)


def sismember(db, key, member):
    """
    See:
      - http://redis.io/commands/sismember
    """
    value = db.get(key, set())
    if member in value:
        return 1
    else:
        return 0


def scard(db, key):
    """
    See:
      - http://redis.io/commands/card
    """
    return len(db.get(key, set()))