using System;
using System.Collections;
using System.IO;
using System.Collections.Generic;
using System.Linq;

namespace Day2
{
    class ProgramDay2
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

        static Dictionary<char, int> stringToHisto(string input)
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

        static List<bool> equalityList(string input1, string input2)
        {
            if (input1.Length != input2.Length)
            {
                throw new Exception("need to have input1 and input2 be the same length");
            }
        
            List<bool> retList = new List<bool>(input1.Length);

            for (var i = 0; i < input1.Length; i++)
            {
                retList.Add(input1[i] == input2[i]);
            }

            return retList;
        }

        static int answerPart1()
        {
            int containsExactlyTwo = 0;
            int contaisExactlyThree = 0;

            foreach (var inputString in fileToStringStream())
            {
                var histo = stringToHisto(inputString);
                if (containsExactlyTwoOfAnyLetter(histo))
                {
                    containsExactlyTwo += 1;
                }

                if (containsExactlyThreeOfAnyLetter(histo))
                {
                    contaisExactlyThree += 1;
                }
            }

            return containsExactlyTwo * contaisExactlyThree;
        }
        
        static void Main(string[] args)
        {
            Console.WriteLine(answerPart1());

            string foo = "abc";
            string bar = "aec";

            var baz = equalityList(foo, bar);
            Console.WriteLine(baz.Count(x => x == false));
            foreach (var i in baz)
            {
                Console.WriteLine(i);
            }

        }
        
    }
}