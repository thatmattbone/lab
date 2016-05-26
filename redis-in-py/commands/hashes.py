"""
Implementation of redis hash commands.

See: http://redis.io/commands#hash

Each command needs to be a callable.
"""

from response import NullResponse


def hset(db, key, field, value):
    """
    See:
      - http://redis.io/commands/hset
    """
    hash = db.setdefault(key, {})

    if field in hash:
        hash[field] = value
        return 0
    else:
        hash[field] = value
        return 1


def hget(db, key, field):
    """
    See:
      - http://redis.io/commands/hset
    """
    if key not in db:
        return None

    hash = db[key]
    if field in hash:
        return hash[field]
    else:
        return NullResponse()


def hlen(db, key):
    """
    See:
      - http://redis.io/commands/hlen
    """
    return len(db.get(key, {}))


def hdel(db, hash_key, *keys):
    """
    See:
      - http://redis.io/commands/hdel
    """
    removed_count = 0
    hash = db[hash_key]
    for key in keys:
        if key in hash:
            removed_count += 1
            del hash[key]
    return removed_count


def hexists(db, hash_key, key):
    """
    See:
      - http://redis.io/commands/hexists
    """
    hash = db.get(hash_key, {})

    if key in hash:
        return 1
    else:
        return 0


def hkeys(db, hash_key):
    """
    See:
      - http://redis.io/commands/hkeys
    """
    # TODO shouldn't need to explictly create a list here...
    return list(db.get(hash_key, {}).keys())


def hvals(db, hash_key):
    """
    See:
      - http://redis.io/commands/hvals
    """
    # TODO shouldn't need to explictly create a list here...
    return list(db.get(hash_key, {}).values())


def hgetall(db, hash_key):
    """
    See:
      - http://redis.io/commands/hgetall
    """
    keys_and_values = []
    for key, value in db.get(hash_key, {}).items():
        keys_and_values.append(key)
        keys_and_values.append(value)
    return keys_and_values