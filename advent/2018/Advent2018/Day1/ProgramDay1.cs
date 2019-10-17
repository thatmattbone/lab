using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Utils;

namespace Day1
{
    public class ProgramDay1
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

        public static int answer1UsingList()
        {
            var answer = 0;
            var myIntList = fileToIntList();
            foreach (var myInt in myIntList)
            {
                answer += myInt;
            }
            return answer;
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

        public static int answer1UsingStream()
        {
            return fileToIntStream().Sum();
        }

        
        public static int answer2UsingStream()
        {
            HashSet<int> seenFreqs = new HashSet<int>();

            int answer = 0;
            foreach (int i in fileToIntStream().StreamForever())
            {
                answer += i;
                if (seenFreqs.Contains(answer))
                {
                    return answer;
                }
                else
                {
                    seenFreqs.Add(answer);
                }
            }

            return -666;
        }
        
        static void Main(string[] args)
        {
            // answer 1 should be 466
            Console.WriteLine(answer1UsingList());
            Console.WriteLine(answer1UsingStream());  
            
            // answer 2 should be 750
            Console.WriteLine(answer2UsingStream());  
        }
    }
}