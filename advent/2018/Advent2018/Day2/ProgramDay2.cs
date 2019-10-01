using System;
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
        
        
        static void Main(string[] args)
        {
            foreach (var i in fileToStringStream())
            {
                Console.WriteLine(i);
            }
        }
    }
}