using System;
using System.Linq;
using Utils;

namespace Day5
{
    public class ProgramDay5
    {
        public static string INPUT_PATH = "/home/mbone/Developer/lab/advent/2018/Advent2018/Day5/input";

        public static bool willReact(char first, char second)
        {
            if (first == second)
            {
                return false;
            }

            if (Char.ToLower(first) == Char.ToLower(second))
            {
                return true;
            }

            return false;
        }

        public static string getInputString()
        {
            return String.Join("", Streams.fileToStringStream(INPUT_PATH).ToArray());
        }
        public static string answerPart1()
        {
            var inputString = getInputString();

            for (int i = 0; i < inputString.Length; i++)
            {
                Console.WriteLine(inputString[i]);
            } 
            
            return "uh oh";
        }

        public static int answerPart2()
        {
            return -2;
        }
        
        static void Main(string[] args)
        {
            Console.WriteLine(answerPart1());
            Console.WriteLine(answerPart2());
        }
    }
}