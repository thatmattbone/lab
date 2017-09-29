"""
Implementation of redis string commands.

See: http://redis.io/commands#string

Each command needs to be a callable.
"""

import fnmatch

from response import NullResponse


def get(db, key):
    """
    See:
      - http://redis.io/commands/get
    """
    result = db.get(key)
    return str(result) if result is not None else NullResponse()


def sset(db, key, value):
    """
    See:
      - http://redis.io/commands/set
    """
    db[key] = value


def mget(db, *requested_keys):
    """
    See:
      - http://redis.io/commands/mget
    """
    return [db.get(requested_key) for requested_key in requested_keys]


def mset(db, *keys_and_values):
    """
    See:
      - http://redis.io/commands/mset
    """
    # this could be more efficient and less pretty:
    keys_and_values = zip(
        [key for i, key in enumerate(keys_and_values) if i % 2 == 0],
        [value for i, value in enumerate(keys_and_values) if i % 2 ==1]
    )
    for key, value in keys_and_values:
        db[key] = value


def incr(db, key, *args, mult=1):
    """
    See:
      - http://redis.io/commands/incr
      - http://redis.io/commands/incrby
      - http://redis.io/commands/decr
      - http://redis.io/commands/decrby
    """
    if len(args) == 0:
        increment = 1 * mult
    elif len(args) == 1:
        increment = args[0] * mult
    else:
        raise Exception("Too many arguments.")

    value = db.get(key, 0)
    value += increment
    db[key] = value

    return value


def append(db, key, append_value):
    """
    See:
      - http://redis.io/commands/append
    """
    value = db.get(key, "")
    new_value = value + append_value
    db[key] = new_value
    return len(new_value)


def strlen(db, key):
    """
    See:
      - http://redis.io/commands/strlen
    """
    return len(db[key])


def keys(db, pattern):
    """
    See:
      - http://redis.io/commands/keys
    """
    return [key for key in db.keys() if fnmatch.fnmatch(key, pattern)]
