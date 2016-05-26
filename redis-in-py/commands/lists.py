"""
Implementation of redis list commands.

See: http://redis.io/commands#list

Each command needs to be a callable.
"""


def rpush(db, key, *args):
    """
    See:
      - http://redis.io/commands/rpush
    """
    mylist = db.setdefault(key, [])
    for arg in args:
        mylist.append(arg)

    return len(mylist)


def llen(db, key):
    """
    See:
      - http://redis.io/commands/llen
    """
    return len(db.get(key, []))


def rpop(db, key):
    """
    See:
      - http://redis.io/commands/rpop
    """
    return str(db[key].pop())