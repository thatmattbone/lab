using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace Day2
{
    public class ProgramDay2
    {
        private static string INPUT_PATH = "/home/mbone/Developer/lab/advent/2018/Advent2018/Day2/input";
        
        static IEnumerable<string> fileToStringStream()
        {
            using (StreamReader sr = new StreamReader(INPUT_PATH))
            {
                string myStr;
                while ((myStr = sr.ReadLine()) != null)
                {
                    yield return myStr;
                }
            }
        }

        public static Dictionary<char, int> stringToHisto(string input)
        {
            var returnDict = new Dictionary<char, int>();

            foreach (var i in input)
            {
                var currentVal = returnDict.GetValueOrDefault(i, 0);
                var newVal = currentVal + 1;
                returnDict[i] = newVal;
            }
            return returnDict;
        }

        static bool containsExactlyTwoOfAnyLetter(Dictionary<char, int> histo)
        {
            return histo.Values.Any(value => value == 2);
        }

        static bool containsExactlyThreeOfAnyLetter(Dictionary<char, int> histo)
        {
            return histo.Values.Any(value => value == 3);
        }

        public static int answerPart1()
        {
            int containsExactlyTwo = 0;
            int containsExactlyThree = 0;

            foreach (var inputString in fileToStringStream())
            {
                var histo = stringToHisto(inputString);
                if (containsExactlyTwoOfAnyLetter(histo))
                {
                    containsExactlyTwo += 1;
                }

                if (containsExactlyThreeOfAnyLetter(histo))
                {
                    containsExactlyThree += 1;
                }
            }

            return containsExactlyTwo * containsExactlyThree;
        }

        // Tuple<char, char> vs (char, char) ???
        static List<(char, char)> zipStrings(string input1, string input2)
        {
            if (input1.Length != input2.Length)
            {
                throw new Exception("need to have input1 and input2 be the same length");
            }

            return input1.Zip(input2).ToList();
        }

        static string commonLetters(List<(char i1, char i2)> input)
        {
            var foo = from charTuple in input
                where charTuple.i1 == charTuple.i2
                select charTuple.i1;
            var bar = foo.ToArray();
            return new String(bar);
        }
        
        static bool offByOne(List<(char i1, char i2)> input)
        {
            var foo = from charTuple in input
                where charTuple.i1 != charTuple.i2
                select true;
            return foo.Count() == 1;
        }

        public static string answerPart2()
        {
            List<string> inputStrings = fileToStringStream().ToList();

            foreach (string inputString in inputStrings)
            {
                foreach (string innerInputString in inputStrings)
                {
                    if (inputString != innerInputString)
                    {
                        var zipped = zipStrings(inputString, innerInputString);
                        if (offByOne(zipped))
                        {
                            return commonLetters(zipped);
                        }
                    }
                }
            }

            return "not the answer.";
        }
        
        static void Main(string[] args)
        {
            Console.WriteLine(answerPart1());
            Console.WriteLine(answerPart2());
        }
        
    }
}