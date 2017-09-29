from commands.strings import (get,
                              sset,
                              incr,
                              strlen,
                              )
                      

def test_get_command():
    db = {}
    assert get(db, "foo") is None

    db["foo"] = 42
    assert get(db, "foo") == "42"


def test_sset_command():
    db = {}
    sset(db, "foo", 42)

    assert db["foo"] == 42


def test_incr_command():
    db = {}

    result = incr(db, "foo")
    assert result == 1
    assert db["foo"] == 1

    result = incr(db, "foo")
    assert result == 2
    assert db["foo"] == 2

    result = incr(db, "foo", 10)
    assert result == 12
    assert db["foo"] == 12

    result = incr(db, "foo", 10, mult=-1)
    assert result == 2
    assert db["foo"] == 2


def test_strlen_command():
    value = "hello, world"
    db = {"message": value}
    
    assert strlen(db, "message") == len(value)

