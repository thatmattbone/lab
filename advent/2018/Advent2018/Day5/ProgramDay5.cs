using System;
using System.Linq;
using Utils;
using System.Collections.Generic;

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

        public static string reactString(string input)
        {
            if (input.Length < 2)
            {
                return input;
            }
            
            List<char> resultChars = new List<char>(input.Length);
            int i = 0;
            while (i < input.Length)
            {
                if (i >= input.Length)
                {
                    break;
                }
                
                if (i == input.Length - 1)
                {
                    resultChars.Add(input[i]);
                    break;
                } 
                
                char first = input[i];
                char second = input[i + 1];

                if (willReact(first, second))
                {
                    i += 2;
                }
                else
                {
                    resultChars.Add(first);
                    i += 1;
                }
            }

            return new String(resultChars.ToArray());
        }

        public static string fullyReactString(string input)
        {
            var currentString = input;
            while (true)
            {
                var reactedString = reactString(currentString);
                if (reactedString == currentString)
                {
                    break;
                }

                currentString = reactedString;
            }

            return currentString;
        }
        
        public static int answerPart1()
        {
            string inputString = getInputString();
            string reactedString = fullyReactString(inputString);

            return reactedString.Length;
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