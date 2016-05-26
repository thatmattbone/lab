# -*- coding: utf-8 -*-

import unittest
from palindrome import *


class TestUtilities(unittest.TestCase):

    def test_format_string(self):
        self.assertEqual('foobar', format_string('foobar'))
        self.assertEqual('foobar', format_string('FOObar'))
        self.assertEqual('foobar', format_string('fooBAr'))
        self.assertEqual('foobas', format_string('fooBA\'s'))
        self.assertEqual('foobar', format_string("foo\nbar"))


    def test_count_falses(self):
        self.assertEqual(0, count_falses([]))
        self.assertEqual(0, count_falses([0]))
        self.assertEqual(1, count_falses([False]))
        self.assertEqual(4, count_falses([False, 0, 4, False, False, 9, 9, False]))


    def test_distinct_len(self):
        self.assertEqual(0, distinct_len(''))
        self.assertEqual(1, distinct_len('ooooooo'))
        self.assertEqual(3, distinct_len('fob'))
        self.assertEqual(5, distinct_len('foobar'))


    def test_str_to_lists(self):
        self.assertEqual((['x', 'y'], ['y', 'x']), str_to_lists('xy'))
        self.assertEqual((['a', 'b', 'c'], ['c', 'b', 'a']), str_to_lists('abc'))

    def test_zip_and_compare(self):
        f, b = str_to_lists('abc')
        self.assertEqual([('a', 'c', False), ('b', 'b', True), ('c', 'a', False)], zip_and_compare(f, b))

class TestIs_Palindrome(unittest.TestCase):

    def setUp(self):
        self.seq = range(10)


    def testFormattedCompare(self):
        self.assertEqual('racecar', formatted_compare('racecar'))
        self.assertEqual(False, formatted_compare('foobar'))
        

    def testPalindromeList(self):
        self.assertEqual(['racecar'], palindrome_list('the racecar went to the store'))
        self.assertEqual([], palindrome_list('the lady went to the store'))

        self.assertEqual(['racecar', 'level'], palindrome_list('the raCeCar is on leveL one'))


    def testIs_Palindrome(self):
        self.assertTrue(is_palindrome('racecar'))
        self.assertFalse(is_palindrome('racecare'))
        self.assertTrue(is_palindrome('racecaR'))

        self.assertFalse(is_palindrome('a'))
        self.assertFalse(is_palindrome('aa'))
        self.assertFalse(is_palindrome('aaa'))
        self.assertTrue(is_palindrome('woaow'))

        self.assertFalse(is_palindrome('EssE'))
        self.assertFalse(is_palindrome('esse'))
        self.assertFalse(is_palindrome('Somos'))
        self.assertFalse(is_palindrome('somos'))

        self.assertFalse(is_palindrome('lol'))
        self.assertFalse(is_palindrome('lolol'))
        self.assertFalse(is_palindrome('lool'))
        self.assertFalse(is_palindrome('hahah'))
        self.assertFalse(is_palindrome('hahahah'))

        self.assertFalse(is_palindrome('+----+'))

        self.assertFalse(is_palindrome('lool'))
        self.assertFalse(is_palindrome('xxxx'))
        self.assertFalse(is_palindrome('somos'))
        self.assertFalse(is_palindrome('*---------*'))
        self.assertFalse(is_palindrome('Xoxox'))
        self.assertFalse(is_palindrome('............'))
        self.assertFalse(is_palindrome('eeeee'))
        self.assertFalse(is_palindrome('!!!!'))
        self.assertFalse(is_palindrome('---'))
        self.assertFalse(is_palindrome('KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK'))
        self.assertFalse(is_palindrome('hahahahah'))
        self.assertFalse(is_palindrome('Maam'))
        self.assertFalse(is_palindrome('Hahahah'))
        self.assertFalse(is_palindrome('yehey'))
        self.assertFalse(is_palindrome('Ooooo'))
        self.assertFalse(is_palindrome('kkkkkkkkkk'))
        self.assertFalse(is_palindrome('Esse'))
        self.assertFalse(is_palindrome('*---*'))
        self.assertFalse(is_palindrome('hahahah'))
        self.assertFalse(is_palindrome('14441'))

        self.assertFalse(is_palindrome(u'今日から少し潜ります。＼テスト爆発しろ／'))

        self.assertFalse(is_palindrome('waw,waw'))


    def testPalindromeSentence(self):
        self.assertFalse(is_palindrome_sentence("""haah"""))
        self.assertFalse(is_palindrome_sentence("""hhhhhhhhhhhhhhhhhhh"""))
        self.assertFalse(is_palindrome_sentence("""just som regular words"""))
        self.assertTrue(is_palindrome_sentence("""“To I, Lester”
A cotton eve,
O, trap! Eden!
O, television sad as night.

I wonder if senile sirs tell war days,
Words selfless, drowsy…

A drawl lets rise lines fired
[No!]
With gin:
Sad as “no” is,
I’ve let one depart.
O, eve–
Not to care…

–T. S. Eliot""") != False)

        self.assertTrue(is_palindrome_sentence("""Race fast, safe car.""") != False)

class TestRandomPalindromes(unittest.TestCase):
    
    SIZE = 10000

    def testRandomPalindromes(self):
        count = 0
        gen = palindrome_generator()
        while(count<self.SIZE):
            word = gen.next()
            #returns word if it is a palindrome
            self.assertTrue(formatted_compare(word) == word)
            self.assertTrue(is_palindrome(word) == word)
            count += 1

    def testRandomSarahPalindromes(self):
        count = 0
        gen = sarahpalindrome_generator()
        while(count<self.SIZE):
            word = gen.next()
            #returns word if it is a palindrome
            self.assertTrue(is_sarahpalindrome(word) == word)
            count += 1


if __name__ == '__main__':
    unittest.main()
