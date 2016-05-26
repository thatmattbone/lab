import re
import random

STOP_LEN = 4
STOP_SET_SIZE = 3
PUNCTUATION_REGEX = re.compile('[^a-z]')
STOP_WORDS = ['somos', 'esse', 'yehey',
              'kodok', 'neuen', 'malam',
              'nuhun']

def format_string(word):
    """Format a string for palindrome testing.  This may be a sentence
    or a word.  In either case, the string is converted to lowercase and
    whitespace (including newlines), punctionation, and non-english
    characters are removed."""
    formatted_word = word.lower()

    return PUNCTUATION_REGEX.subn('', formatted_word)[0]


def count_falses(items, key=lambda x: x):
    """Return the number of False items in a list, using the specified 
    key function to access each item in the list."""
    false_count = 0
    for item in items:
        true_or_false = key(item)
        if(true_or_false is False):
            false_count += 1
    return false_count


def distinct_len(word):
    """Return the # of distinct letters in a string."""
    forwords = list(word)
    forwords_set = set(forwords)
    return len(forwords_set)


def str_to_lists(word):
    """For a given word return a list of characters both forwards and backwards."""
    forwards = list(word)
    backwards = list(word)
    backwards.reverse()
    
    return (forwards, backwards)


def zip_and_compare(forwards, backwards):
    """Zip two lists of equal length into a tuple that whose third element 
    is the comparision of the first two."""
    zipped = zip(forwards, backwards)

    return [(x[0], x[1], x[0] == x[1]) for x in zipped]


def formatted_compare(word):
    """The heart of the palindrome comparison algorithm, this
    is the forwards = backwards check."""
    forwards, backwards = str_to_lists(word)
    
    if(forwards == backwards):
        return word
    else:
        return False
    

def is_palindrome(word):
    formatted_word = format_string(word)

    if(len(formatted_word) < STOP_LEN):
        return False

    if(formatted_word in STOP_WORDS):
        return False

    if(distinct_len(formatted_word) < STOP_SET_SIZE):
        return False

    return formatted_compare(formatted_word)
    

def is_palindrome_sentence(sentence):
    """Test an entire sentence to see if it is a palindrome.  Puncuation,
    linebreaks, spaces, etc, are removed before the test is made.

    Returns False or the pre-formatting sentence"""
    formatted_sentence = format_string(sentence)
    if(len(formatted_sentence) < STOP_LEN):
        return False

    if(distinct_len(formatted_sentence) < STOP_SET_SIZE):
        return False

    compared = formatted_compare(formatted_sentence)

    if(compared == False):
        return False
    else:
        return sentence


def palindrome_list(sentence):
    """Split a sentence into words (on spaces)  and test each word individually
    to determine whether or not it is a palindrome.  

    Return a list of palindromes (post-formatting)."""

    words = [word.strip() for word in sentence.split()]
    palindrome_list = [is_palindrome(word) for word in words]
    return [w for w in palindrome_list if w!=False]


def is_sarahpalindrome(word):
    formatted_word = format_string(word)

    if(len(formatted_word) < STOP_LEN):
        return False

    if(formatted_word in STOP_WORDS):
        return False

    if(distinct_len(formatted_word) < STOP_SET_SIZE):
        return False

    forwards, backwards = str_to_lists(formatted_word)

    zipped_list = zip_and_compare(forwards, backwards)

    false_count = count_falses(zipped_list, key=lambda x: x[2])

    #0 means a palindrome -- but must test with more restricitons
    if(false_count == 0):
        return formatted_compare(word)

    #2 or 4 are the only acceptable cases
    #if(false_count != 2 and false_count != 4):
    if(false_count != 4):
        return False

    # the falses also have to be contiguous

    fi1 = None #forward index 1
    fi2 = None #forward index 2
    n = 0
    for t in zipped_list:
        if(fi1 is None and t[2] is False):
            fi1 = n
        elif(fi2 is None and t[2] is False):
            fi2 = n
        n+=1
    if(fi1+1 != fi2):
        return False
    bi1 = -1*fi1 - 1
    bi2 = -1*fi2 - 1
                 
    #ick
    s = [x[0] for x in zipped_list]
    t = [x[1] for x in zipped_list]

    if(s[fi1] == t[fi2] and 
       s[fi2] == t[fi1] and 
       s[bi2] == t[bi1] and 
       s[bi1] == t[bi2]):
        return formatted_word

    return False

    
letters = 'abcdefghijklmnopqrstuvwxyz'
def palindrome_generator():
    letter_list = list(letters)
    
    while(True):
        p_length = random.randint(2, 10)
        palindrome_forward = random.sample(letter_list, p_length)
        palindrome_backward = list(palindrome_forward)
        palindrome_backward.reverse()
        possible_palindrome = "%s%s" % ("".join(palindrome_forward), "".join(palindrome_backward))

        if(possible_palindrome in STOP_WORDS):
            continue

        if(distinct_len(possible_palindrome) < STOP_SET_SIZE):
            continue


        yield possible_palindrome


def sarahpalindrome_generator(no_palindromes=True):
    gen = palindrome_generator()
    for palindrome in palindrome_generator():
        letter_list = list(palindrome)
        swapme = random.randint(0, len(letter_list)-2)
        l1 = letter_list[swapme]
        l2 = letter_list[swapme+1]
        letter_list[swapme] = l2
        letter_list[swapme+1] = l1
        possible_palindrome = "".join(letter_list)
        
        if(no_palindromes and formatted_compare(possible_palindrome)):
            continue

        yield possible_palindrome


if __name__ == '__main__':
    print(is_sarahpalindrome('hello'))
    sp = sarahpalindrome_generator()
    print(is_sarahpalindrome(sp.next()))
