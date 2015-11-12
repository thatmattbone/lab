from bloom_filter import BloomFilter

# ##  Sample application  ##############################################

# class SpellChecker(BloomFilter):

#     def __init__(self, wordlistfiles, estimated_word_count=125000):
#         num_probes = 14           # set higher for fewer false positives
#         num_bytes = estimated_word_count * num_probes * 3 // 2 // 8
#         wordlist = (w.strip() for f in wordlistfiles for w in open(f))
#         BloomFilter.__init__(self, num_bytes, num_probes, wordlist)

#     def find_misspellings(self, text):
#         return [word for word in text.lower().split() if word not in self]

    ## Compute effectiveness statistics for a 125 byte filter with 50 entries

# from random import sample
# from string import ascii_letters

# states = '''Alabama Alaska Arizona Arkansas California Colorado Connecticut
#     Delaware Florida Georgia Hawaii Idaho Illinois Indiana Iowa Kansas
#     Kentucky Louisiana Maine Maryland Massachusetts Michigan Minnesota
#     Mississippi Missouri Montana Nebraska Nevada NewHampshire NewJersey
#     NewMexico NewYork NorthCarolina NorthDakota Ohio Oklahoma Oregon
#     Pennsylvania RhodeIsland SouthCarolina SouthDakota Tennessee Texas Utah
#     Vermont Virginia Washington WestVirginia Wisconsin Wyoming'''.split()

# bf = BloomFilter(num_bytes=125, num_probes=14, iterable=states)

# m = sum(state in bf for state in states)
# print('%d true positives and %d false negatives out of %d positive trials'
#       % (m, len(states)-m, len(states)))

# trials = 100000
# m = sum(''.join(sample(ascii_letters, 8)) in bf for i in range(trials))
# print('%d true negatives and %d false positives out of %d negative trials'
#       % (trials-m, m, trials))

# c = ''.join(format(x, '08b') for x in bf.array)
# print('Bit density:', c.count('1') / float(len(c)))


# ## Demonstrate a simple spell checker using a 125,000 word English wordlist

# from glob import glob
# from pprint import pprint

# # Use the GNU ispell wordlist found at http://bit.ly/english_dictionary
# checker = SpellChecker(glob('/Users/raymondhettinger/dictionary/english.?'))
# pprint(checker.find_misspellings('''
#     All the werldz a stage
#     And all the mehn and wwomen merrely players
#     They have their exits and their entrances
#     And one man in his thaim pllays many parts
#     His actts being sevven ages
# '''))

def test_simple_insert():
    test_set = ('one', 'two', 'three')
    bf = BloomFilter(num_bytes=125, num_probes=14, iterable=test_set)

    assert 'one' in bf
    assert 'two' in bf
    assert 'three' in bf
    assert 'four' not in bf
                     
