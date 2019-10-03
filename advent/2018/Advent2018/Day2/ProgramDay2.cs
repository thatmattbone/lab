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
        
        static void Main(string[] args)
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
            
            Console.WriteLine(containsExactlyTwo * contaisExactlyThree);
        }
    }
}