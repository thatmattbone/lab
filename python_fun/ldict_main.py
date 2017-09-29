from lazydictionary import LazyDictionary

def delay_this_computation():
    return {'some_key': 'some_value'}

ldict = LazyDictionary(callback=delay_this_computation)

ldict['some_other_key'] = 'some_other_value'
