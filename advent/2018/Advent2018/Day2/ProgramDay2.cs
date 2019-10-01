using System;
using System.Collections;
using System.IO;
using System.Collections.Generic;

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
        
        static void Main(string[] args)
        {
            foreach (var inputString in fileToStringStream())
            {
                var histo = stringToHisto(inputString);
            }
        }
    }
}