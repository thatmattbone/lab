"""
Bloom filter implementation from:
 - http://code.activestate.com/recipes/577684-bloom-filter/
"""
from random import Random
from hashlib import sha224, sha256


class BloomFilter:
    """
    http://en.wikipedia.org/wiki/Bloom_filter
    """

    def __init__(self, num_bytes, num_probes, iterable=()):
        self.array = bytearray(num_bytes)
        self.num_probes = num_probes
        self.num_bins = num_bytes * 8
        self.update(iterable)

    def get_probes(self, key):
        random = Random(key).random
        return (int(random() * self.num_bins) for _ in range(self.num_probes))

    def update(self, keys):
        for key in keys:
            for i in self.get_probes(key):
                self.array[i//8] |= 2 ** (i%8)

    def __contains__(self, key):
        return all(self.array[i//8] & (2 ** (i%8)) for i in self.get_probes(key))


class BloomFilter_4k(BloomFilter):
    """
    4Kb (2**15 bins) 13 probes. Holds 1,700 entries with 1 error per 10,000.
    """

    def __init__(self, iterable=()):
        BloomFilter.__init__(self, 4 * 1024, 13, iterable)

    def get_probes(self, key):
        h = int(sha224(key.encode()).hexdigest(), 16)
        for _ in range(13):
            yield h & 32767     # 2 ** 15 - 1
            h >>= 15


class BloomFilter_32k(BloomFilter):
    """
    32kb (2**18 bins), 13 probes. Holds 13,600 entries with 1 error per 10,000.
    """

    def __init__(self, iterable=()):
        BloomFilter.__init__(self, 32 * 1024, 13, iterable)

    def get_probes(self, key):
        h = int(sha256(key.encode()).hexdigest(), 16)
        for _ in range(13):
            yield h & 262143    # 2 ** 18 - 1
            h >>= 18
