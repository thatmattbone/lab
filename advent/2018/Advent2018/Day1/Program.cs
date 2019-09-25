using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace Day1
{
    class Program
    {
        private static string INPUT_PATH = "/home/mbone/Developer/lab/advent/2018/Advent2018/Day1/input";
        
        static int stringToInt(string inputString)
        {
            return Int32.Parse(inputString);
        }

        static List<int> fileToIntList()
        {
            List<int> returnList = new List<int>();
            
            using (StreamReader sr = new StreamReader(INPUT_PATH))
            {
                int initialValue = 0;

                string intStr;
                
                while ((intStr = sr.ReadLine()) != null)
                {
                    int valueFromFile = stringToInt(intStr);
                    returnList.Add(valueFromFile);
                }
            }

            return returnList;
        }

        static void answerUsingList()
        {
            var answer = 0;
            var myIntList = fileToIntList();
            foreach (var myInt in myIntList)
            {
                answer += myInt;
            }
            Console.WriteLine(answer);
        }
        
        static IEnumerable<int> fileToIntStream()
        {
            using (StreamReader sr = new StreamReader(INPUT_PATH))
            {
                string intStr;
                while ((intStr = sr.ReadLine()) != null)
                {
                    yield return stringToInt(intStr);
                }
            }
        }

        static void answerUsingStream()
        {
            Console.WriteLine(fileToIntStream().Sum());
        }
        
        static void Main(string[] args)
        {
            answerUsingList();
            answerUsingStream();
        }
    }
}