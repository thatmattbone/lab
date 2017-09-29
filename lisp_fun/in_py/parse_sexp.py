import re

open_paren_re = re.compile('\(')
close_paren_re = re.compile('\)')
symbol_start_re = re.compile('[a-zA-Z\+\-]')
number_re = re.compile('[0-9]')
whitespace_re = re.compile(' ')

class next_token_exception(Exception): pass

class syntax_exception(Exception): pass

class token(object):
    def __init__(self, value):
        self.value = value


class open_paren_token(token):
    def __add__(self, x):
        raise next_token_exception()


class close_paren_token(token):
    def __add__(self, x):
        raise next_token_exception()
    

class symbol_token(token):
    def __add__(self, x):
        if isinstance(x, symbol_token) or isinstance(x, number_token):
            return symbol_token(self.value + x.value)          
        else:
            raise next_token_exception()


class number_token(token):
    def __add__(self, x):
        if isinstance(x, symbol_token):
            raise syntax_exception("symbols cannot start with a number")
        elif isinstance(x, number_token):
            return number_token(self.value + x.value)
            return self
        else:
            raise next_token_exception()
        

class whitespace_token(token):

    def __add__(self, x):
        if(isinstance(x, whitespace_token)):
            return whitespace_token(self.value + x.value)
        else:
            raise next_token_exception()


RE_TO_TOKEN_MAP = {
    close_paren_re: close_paren_token,
    open_paren_re: open_paren_token,
    symbol_start_re: symbol_token,
    number_re:number_token,
    whitespace_re: whitespace_token,
    }

def char_to_token(char):
    matches = []

    for regex, klass in RE_TO_TOKEN_MAP.items():
        if(regex.match(char)):
            matches.append(klass(char))

    if(len(matches) == 0):
        #TODO specify exception and test
        raise Exception("Could not match symbol %s" % char)

    if(len(matches) > 1):
        #TODO specify exception and test
        raise Exception("Ambiguous symbol %s" % char)

    return matches[0]

def _tokenize(some_string):

    current_token = None
    
    for char in some_string:
        token = char_to_token(char)

        if current_token is None:
            current_token = token

        else:

            try:
                current_token = current_token + token
            except next_token_exception:
                yield current_token
                current_token = token

    yield current_token
 

def tokenize(some_string):
    for token in _tokenize(some_string):
        if not isinstance(token, whitespace_token):
            yield token


class Number(object):
    def __init__(self, value):
        self.value = int(value)

    def __eq__(self, other):
        return self.value == other.value

    def __repr__(self):
        return "Number(%s)" % self.value
    
class Symbol(object):
    def __init__(self, value):
        self.value = value

    def __eq__(self, other):
        return self.value == other.value

    def __repr__(self):
        return "Symbol(%s)" % self.value


def parse(tokens):
    
    stack = list()
    top = None
    
    for token in tokens:

        if isinstance(token, open_paren_token):
            if len(stack) == 0:
                top = list()
                stack.append(top)
                
            else:
                new_list = list()
                stack[-1].append(new_list) #append to item currently on the stack
                stack.append(new_list)
                
        elif isinstance(token, close_paren_token):
            stack.pop()
           
        elif isinstance(token, symbol_token):
            if stack is None: raise syntax_exception()

            stack[-1].append(Symbol(token.value))
       
        elif isinstance(token, number_token):
            if stack is None: raise syntax_exception()

            stack[-1].append(Number(token.value))
            
        else:
            raise Exception("Unkown token %s" % token)

    if len(stack) != 0: raise syntax_exception("Unbalanced Parentheses: %s" % len(stack))
    
    return top

def sexp_to_tree(sexp):
    return parse(tokenize(sexp))

import unittest
class TestParser(unittest.TestCase):

    def test_simple_parse(self):
        tokens = [open_paren_token("("),
                  symbol_token("a"),
                  close_paren_token(")")]
        
        tree = parse(tokens)

        self.assertTrue(isinstance(tree, list))
        self.assertEqual(1, len(tree))

        self.assertEqual(tree[0], Symbol("a"))

    def test_less_simple_parse(self):
        tokens = [open_paren_token("("),
                  symbol_token("+"),
                  number_token("1"),
                  open_paren_token("("),
                  symbol_token("+"),
                  number_token("2"),
                  number_token("2"),
                  close_paren_token(")"),
                  close_paren_token(")")
                  ]
        
        tree = parse(tokens)

        expected = [Symbol("+"),
                    Number("1"),
                    [Symbol("+"),
                     Number("2"),
                     Number("2"),]
                    ]
        self.assertEqual(tree, expected)

        tree = sexp_to_tree("(+ 1 (+ 2 2))")
        self.assertEqual(tree, expected)
    

class TestTokenizer(unittest.TestCase):
    def test_char_to_token(self):

        a = char_to_token("a")
        self.assertTrue(isinstance(a, symbol_token))
        self.assertEqual(a.value, "a")

        nine = char_to_token("9")
        self.assertTrue(isinstance(nine, number_token))
        self.assertEqual(nine.value, "9")

        open = char_to_token("(")
        self.assertTrue(isinstance(open, open_paren_token))
        self.assertEqual(open.value, "(")

        close = char_to_token(")")
        self.assertTrue(isinstance(close, close_paren_token))
        self.assertEqual(close.value, ")")

        space = char_to_token(" ")
        self.assertTrue(isinstance(space, whitespace_token))
        self.assertEqual(space.value, " ")


    def test_simple_under_tokenize(self):
        tokens = list(_tokenize("a"))
        self.assertEqual(len(tokens), 1)
        token = tokens[0]
        self.assertTrue(isinstance(token, symbol_token))
        self.assertEqual(token.value, "a")
        
        tokens = list(_tokenize("abcd"))
        self.assertEqual(len(tokens), 1)
        token = tokens[0]
        self.assertTrue(isinstance(token, symbol_token))
        self.assertEqual(token.value, "abcd")

        tokens = list(_tokenize("ab9+1-"))
        self.assertEqual(len(tokens), 1)
        token = tokens[0]
        self.assertTrue(isinstance(token, symbol_token))
        self.assertEqual(token.value, "ab9+1-")

        tokens = list(_tokenize("9"))
        self.assertEqual(len(tokens), 1)
        token = tokens[0]
        self.assertTrue(isinstance(token, number_token))
        self.assertEqual(token.value, "9")
        
        tokens = list(_tokenize("9876"))
        self.assertEqual(len(tokens), 1)
        token = tokens[0]
        self.assertTrue(isinstance(token, number_token))
        self.assertEqual(token.value, "9876")


    def test_complex_under_tokenize(self):
        tokens = list(_tokenize("(ab9+1-  999)"))
        self.assertEqual(len(tokens), 5)

        open = tokens[0]
        sym = tokens[1]
        space = tokens[2]
        num = tokens[3]
        close = tokens[4]        

        self.assertTrue(isinstance(open, open_paren_token))
        self.assertEqual(open.value, "(")
        
        self.assertTrue(isinstance(sym, symbol_token))
        self.assertEqual(sym.value, "ab9+1-")

        self.assertTrue(isinstance(space, whitespace_token))
        self.assertEqual(space.value, "  ")

        self.assertTrue(isinstance(num, number_token))
        self.assertEqual(num.value, "999")
                
        self.assertTrue(isinstance(close, close_paren_token))
        self.assertEqual(close.value, ")")


    def test_tokenize(self):
        tokens = list(tokenize("(ab9+1-  999)"))
        self.assertEqual(len(tokens), 4)

        open = tokens[0]
        sym = tokens[1]
        num = tokens[2]
        close = tokens[3]        

        self.assertTrue(isinstance(open, open_paren_token))
        self.assertEqual(open.value, "(")
        
        self.assertTrue(isinstance(sym, symbol_token))
        self.assertEqual(sym.value, "ab9+1-")

        self.assertTrue(isinstance(num, number_token))
        self.assertEqual(num.value, "999")
                
        self.assertTrue(isinstance(close, close_paren_token))
        self.assertEqual(close.value, ")")


    def test_symbol_number_error(self):
        self.failUnlessRaises(syntax_exception, lambda: list(_tokenize("9abc")))
        self.failUnlessRaises(syntax_exception, lambda: list(_tokenize("989abc")))
        

class TestTokens(unittest.TestCase):
    """Test the token classes which are responsible for determining
    what characters can be pushed together (i.e. they contain
    the real logic about what characters constitute a token."""


    def test_symbol_token(self):        
        a = symbol_token("a")
        b = symbol_token("b")

        new_sym = a+b

        self.assertEqual("ab", new_sym.value)
        self.assertTrue(isinstance(new_sym, symbol_token))

        ab = new_sym

        space = whitespace_token(" ")
        self.failUnlessRaises(next_token_exception, lambda: ab + space)

        nine = number_token("9")
        ab9 = ab + nine
        self.assertEqual(ab9.value, "ab9")
        self.assertTrue(isinstance(ab9, symbol_token))        


    def test_number_token(self):
        one = number_token("1")
        two = number_token("2")

        twelve = one + two
        self.assertEqual(twelve.value, "12")
        self.assertTrue(isinstance(twelve, number_token))
        
        a = symbol_token("a")
        self.failUnlessRaises(syntax_exception, lambda: twelve + a)

        paren = open_paren_token("(")
        self.failUnlessRaises(next_token_exception, lambda: twelve + paren)


    def test_whitespace_token(self):
        s1 = whitespace_token(" ")
        s2 = whitespace_token(" ")        

        spaces = s1 + s2
        self.assertEqual(spaces.value, "  ")
        self.assertTrue(isinstance(spaces, whitespace_token))

        forty_two = number_token("42")
        self.failUnlessRaises(next_token_exception, lambda: spaces + forty_two)


    def test_paren_tokens(self):
        open = open_paren_token("(")
        close = close_paren_token(")")
        s1 = whitespace_token(" ")
        two = number_token("2")
        a = symbol_token("a")
        
        self.failUnlessRaises(next_token_exception, lambda: open + close)
        self.failUnlessRaises(next_token_exception, lambda: close + open)
        self.failUnlessRaises(next_token_exception, lambda: open + s1)
        self.failUnlessRaises(next_token_exception, lambda: open + two)
        self.failUnlessRaises(next_token_exception, lambda: open + a)        
        self.failUnlessRaises(next_token_exception, lambda: close + s1)
        self.failUnlessRaises(next_token_exception, lambda: close + two)
        self.failUnlessRaises(next_token_exception, lambda: close + a)        


class TestRegex(unittest.TestCase):
    
    def test_open_paren(self):
        self.assertTrue(open_paren_re.match('(') is not None)
        self.assertTrue(open_paren_re.match(')') is None)
        self.assertTrue(open_paren_re.match('+') is None)
        self.assertTrue(open_paren_re.match('9') is None)
        self.assertTrue(open_paren_re.match('a') is None)
        self.assertTrue(open_paren_re.match('A') is None)        
        self.assertTrue(open_paren_re.match('m') is None)
        self.assertTrue(open_paren_re.match('M') is None)        


    def test_close_paren(self):
        self.assertTrue(close_paren_re.match(')') is not None)
        self.assertTrue(close_paren_re.match('(') is None)

        self.assertTrue(close_paren_re.match('+') is None)
        self.assertTrue(close_paren_re.match('9') is None)
        self.assertTrue(close_paren_re.match('a') is None)
        self.assertTrue(close_paren_re.match('A') is None)        
        self.assertTrue(close_paren_re.match('m') is None)
        self.assertTrue(close_paren_re.match('M') is None)                


    def test_symbol_start(self):
        self.assertTrue(symbol_start_re.match(')') is None)
        self.assertTrue(symbol_start_re.match('(') is None)
        self.assertTrue(symbol_start_re.match('+') is not None)
        self.assertTrue(symbol_start_re.match('9') is None)
        self.assertTrue(symbol_start_re.match('a') is not None)
        self.assertTrue(symbol_start_re.match('A') is not None)        
        self.assertTrue(symbol_start_re.match('m') is not None)
        self.assertTrue(symbol_start_re.match('M') is not None)        


    def test_number(self):
        self.assertTrue(number_re.match(')') is None)
        self.assertTrue(number_re.match('(') is None)
        self.assertTrue(number_re.match('+') is None)

        self.assertTrue(number_re.match('9') is not None)
        self.assertTrue(number_re.match('a') is None)
        self.assertTrue(number_re.match('A') is None)        
        self.assertTrue(number_re.match('m') is None)
        self.assertTrue(number_re.match('M') is None)

    def test_whitespace(self):
        self.assertTrue(whitespace_re.match(')') is None)
        self.assertTrue(whitespace_re.match('(') is None)
        self.assertTrue(whitespace_re.match('+') is None)
        self.assertTrue(whitespace_re.match('9') is None)
        self.assertTrue(whitespace_re.match('a') is None)
        self.assertTrue(whitespace_re.match('A') is None)        
        self.assertTrue(whitespace_re.match('m') is None)
        self.assertTrue(whitespace_re.match('M') is None)
        self.assertTrue(whitespace_re.match(' ') is not None)        
        
        

if __name__ == '__main__':
    unittest.main()

