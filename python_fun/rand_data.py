import random

def rand_good_char():
    return chr(random.randint(97, 122))

def rand_domain():
    return random.choice(['gmail.com', 'yahoo.com', 'hotmail.com',
                          'live.com', 'comcast.net', 'prodigy.net',
                          'couponcabin.net', 'boeing.com', 'teap8ty.gov'])

def rand_email():
    return "%s@%s" %("".join([rand_good_char() for x in range(random.randint(5, 13))]),
                     rand_domain())

if __name__ == "__main__":
    for i in range(0,1000000):
        print rand_email()
    
#test how long to cram into pymongo
#test how long to increment each in pymongo
