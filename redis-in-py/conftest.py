import redis

def pytest_addoption(parser):
    parser.addoption("--redis-host",
                     default="127.0.0.1",
                     help="redis host.")
    parser.addoption("--redis-port",
                     default=6379,
                     type=int,
                     help="redis port")


def pytest_generate_tests(metafunc):
    if 'redis' in metafunc.fixturenames:

        host = metafunc.config.getoption('redis_host')
        port = metafunc.config.getoption('redis_port')

        r = redis.StrictRedis(host=host, port=port, db=0)

        metafunc.parametrize("redis",
                             [r])


def pytest_runtest_setup(item):
    try:
        if item.funcargnames.index("redis") == 0:
            item.funcargs["redis"].flushdb()
    except ValueError:
        pass
