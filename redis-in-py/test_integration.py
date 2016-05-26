"""
Simple integration tests that we can run against a real redis server
and our clone.

Eventually we should try to get the real redis test suite to run
against our clone if possible.
"""


def test_delete(redis):
    redis.set("hello", "world")
    redis.set("hello1", "world1")
    redis.set("hello2", "world2")

    assert b"world" == redis.get("hello")
    assert b"world1" == redis.get("hello1")
    assert b"world2" == redis.get("hello2")

    removed = redis.delete("hello")
    assert removed == 1

    assert redis.get("hello") is None
    assert b"world1" == redis.get("hello1")
    assert b"world2" == redis.get("hello2")

    removed = redis.delete("hello1", "hello2")
    assert removed == 2

    assert redis.get("hello1") is None
    assert redis.get("hello2") is None
    assert redis.get("hello3") is None

    removed = redis.delete("hello")
    assert removed == 0


def test_set_and_get(redis):
    redis.set("hello", "world")
    assert b"world" == redis.get("hello")

    redis.set("hello", 1)
    assert b'1' == redis.get("hello")


def test_mset(redis):
    redis.mset({'foo': 'bar',
                'biz': 'baz'})

    assert b"bar" == redis.get("foo")
    assert b"baz" == redis.get("biz")


def test_mget(redis):
    redis.set('foo', 'bar')
    redis.set('biz', 'baz')

    bar, baz = redis.mget(["foo", "biz"])
    assert bar == b"bar"
    assert baz == b"baz"


def test_incr(redis):
    redis.set("counter", 1)
    counter = redis.incr("counter")  # boo, always uses incrby
    assert counter == 2
    assert b'2' == redis.get("counter")


def test_incrby(redis):
    redis.set("counter", 1)
    counter = redis.incr("counter", 9)
    assert counter == 10
    assert b'10' == redis.get("counter")


def test_decr(redis):
    redis.set("counter", 10)
    counter = redis.decr("counter")  # boo, always uses decrby
    assert counter == 9
    assert b'9' == redis.get("counter")


def test_decrby(redis):
    redis.set("counter", 10)
    counter = redis.decr("counter", 9)
    assert counter == 1
    assert b'1' == redis.get("counter")


def test_strlen(redis):
    value = "hello bar"
    redis.set("foo", value)
    
    assert len(value) == redis.strlen("foo")
    

def test_append(redis):
    value = "foo"
    redis.set("bar", value)
    redis.get("bar") == b"foo"
    redis.append("bar", "bar")
    assert redis.get("bar") == b"foobar"


def test_rpush(redis):
    assert redis.rpush("foo", "1") == 1
    assert redis.rpush("foo", "2") == 2

    assert redis.llen("foo") == 2
    

def test_rpop(redis):
    assert redis.rpush("foo", "9", "8", "7") == 3
    assert redis.rpop("foo") == b"7"
    assert redis.rpop("foo") == b"8"
    assert redis.rpop("foo") == b"9"

    assert redis.llen("foo") == 0


def test_sadd(redis):
    assert redis.sadd("newset", "1", "2", "2") == 2
    assert redis.scard("newset") == 2


def test_sismember(redis):
    redis.sadd("newset", "1", "2", "3")
    assert redis.sismember("newset", "1") == 1
    assert redis.sismember("newset", "99") == 0


def test_hset(redis):
    assert redis.hset("myhash", "foo", "bar") == 1
    assert redis.hset("myhash", "baz", "biz") == 1

    assert redis.hget("myhash", "foo") == b"bar"
    assert redis.hget("myhash", "baz") == b"biz"

    assert redis.hlen("myhash") == 2

    assert redis.hset("myhash", "baz", "boz") == 0
    assert redis.hget("myhash", "baz") == b"boz"


def test_hdel(redis):
    redis.hset("hash1", "foo", "bar")
    assert redis.hget("hash1", "foo") == b"bar"
    assert redis.hlen("hash1") == 1

    assert redis.hdel("hash1", "foo") == 1
    assert redis.hget("hash1", "foo") is None
    assert redis.hlen("hash1") == 0


def test_hexists(redis):
    redis.hset("hash1", "foo", "bar")

    assert redis.hexists("hash1", "foo") == 1
    assert redis.hexists("hash1", "bar") == 0


def test_hkeys(redis):
    redis.hset("hash1", "foo", "bar")
    redis.hset("hash1", "baz", "biz")

    keys = redis.hkeys("hash1")
    assert len(keys) == 2
    assert b"foo" in keys
    assert b"baz" in keys


def test_hvals(redis):
    redis.hset("hash1", "foo", "bar")
    redis.hset("hash1", "baz", "biz")

    values = redis.hvals("hash1")
    assert len(values) == 2
    assert b"bar" in values
    assert b"biz" in values


def test_hgetall(redis):
    redis.hset("hash1", "foo", "bar")
    redis.hset("hash1", "baz", "biz")

    assert redis.hgetall("hash1") == {b'foo': b'bar',
                                      b'baz': b'biz'}


def test_dbsize(redis):
    redis.set("foo", "bar")
    redis.set("baz", "biz")
    assert redis.dbsize() == 2


def test_echo(redis):
    assert redis.echo("hello world") == b"hello world"


def test_keys(redis):
    def only_contains(iterable, test_items):
        assert len(iterable) == len(test_items)

        s_iterable = set(iterable)

        for test_item in test_items:
            assert test_item in s_iterable

    test_data = {
        'hello1': 'world1',
        'hello2': 'world2',
        'hello3': 'hello3',
        'helloA': 'helloA',
    }
    for key, value in test_data.items():
        redis.set(key, value)

    only_contains([key.encode() for key in test_data.keys()], redis.keys("*"))
    only_contains([b"hello1", b"hello2", b"hello3"], redis.keys("hello[1-9]"))
    only_contains([b"helloA",], redis.keys("hello[A-Z]"))


def test_rename(redis):
    redis.set("foo", "bar")

    redis.rename("foo", "baz")

    assert redis.get("foo") is None
    assert redis.get("baz") == b"bar"