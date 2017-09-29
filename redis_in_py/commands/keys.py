"""
Implementation of redis key commands.

See: http://redis.io/commands#generic

Each command needs to be a callable.
"""


def delete(db, *keys):
    """
    See:
      - http://redis.io/commands/del
    """
    removed_count = 0
    for key in keys:
        if key in db:
            del db[key]
            removed_count += 1

    return removed_count


def rename(db, key, newkey):
    """
    See:
      - http://redis.io/commands/rename
    """
    value = db[key]
    del db[key]
    db[newkey] = value
