class LazyDictionary(object):

    def __init__(self, callback=dict):
        self.data = None
        self.callback = callback

    def evaluate_callback(self):
        self.data = self.callback()

    def __getitem__(self, name):
        if(self.data is None):
            self.evaluate_callback()
        return self.data.__getitem__(name)

    def __setitem__(self, name, value):
        if(self.data is None):
            self.evaluate_callback()
        return self.data.__setitem__(name, value)

    def __getattr__(self, name):
        if(self.data is None):
            self.evaluate_callback()

        #if(name != 'evaluate_callback'):
        return getattr(self.data, name)

import unittest
evaluated = False
class LazyDictionaryTest(unittest.TestCase):

    def test_simple_get_set(self):
        ldict = LazyDictionary()
        ldict['asdf'] = 'jkl'

        self.assertEqual('jkl', ldict['asdf'])

    def test_evaluate_callback(self):
        global evaluated

        evaluated = False
        
        def callback():
            global evaluated
            evaluated = True
            return {'foo':'bar'}

        ldict = LazyDictionary(callback=callback)

        #have not forced evaluation of callback yet
        self.assertFalse(evaluated)

        #lookup forces evaluation, test result
        self.assertEqual('bar', ldict['foo'])
        self.assertTrue(evaluated)

    def test_attributes(self):
        def callback():
            return {'foo':'bar'}
        
        ldict = LazyDictionary(callback=callback)

        self.assertTrue(ldict.has_key('foo'))
            
if __name__ == '__main__':
    unittest.main()
