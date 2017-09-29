"""
Redis backend.

Mostly this maps strings to functions.
"""

from functools import partial

from commands.keys import delete, rename
from commands.strings import incr, get, strlen, append, sset, mset, mget, keys
from commands.hashes import hset, hget, hlen, hdel, hexists, hkeys, hvals, hgetall
from commands.lists import rpush, rpop, llen
from commands.sets import sadd, scard, sismember
from commands.connection import ping, echo
from commands.server import flushdb, dbsize


class Backend(object):

    def __init__(self):
        self.db = {}  # should eventually support multiple dbs 

        self.commands = {
            #keys
            'del': partial(delete, self.db),
            'rename': partial(rename, self.db),

            # strings
            'incr': partial(incr, self.db),
            'incrby': partial(incr, self.db),
            'decr': partial(incr, self.db, mult=-1),
            'decrby': partial(incr, self.db, mult=-1),
            'set': partial(sset, self.db),
            'get': partial(get, self.db),
            'mset': partial(mset, self.db),
            'mget': partial(mget, self.db),
            'strlen': partial(strlen, self.db),
            'append': partial(append, self.db),
            'keys': partial(keys, self.db),

            # hashes
            'hset': partial(hset, self.db),
            'hget': partial(hget, self.db),
            'hlen': partial(hlen, self.db),
            'hdel': partial(hdel, self.db),
            'hexists': partial(hexists, self.db),
            'hkeys': partial(hkeys, self.db),
            'hvals': partial(hvals, self.db),
            'hgetall': partial(hgetall, self.db),

            # lists
            'rpush': partial(rpush, self.db),
            'rpop': partial(rpop, self.db),
            'llen': partial(llen, self.db),

            #sets
            'sadd': partial(sadd, self.db),
            'scard': partial(scard, self.db),
            'sismember': partial(sismember, self.db),

            # connection
            'ping': ping,
            'echo': echo,

            # server
            'flushdb': partial(flushdb, self.db),
            'dbsize': partial(dbsize, self.db),
        }
    
    def dispatch(self, command, args):
        return self.commands[command](*args)
