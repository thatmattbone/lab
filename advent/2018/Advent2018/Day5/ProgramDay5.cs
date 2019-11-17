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

        public static HashSet<char> setOfChars(string inputString)
        {
            var mySet = new HashSet<char>(30);
            foreach (char c in inputString)
            {
                mySet.Add(Char.ToLower(c));
            }

            return mySet;
        }

        public static string removeChar(string inputString, char c)
        {
            string returnString = inputString.Replace(Char.ToLower(c).ToString(), string.Empty);
            returnString = returnString.Replace(Char.ToUpper(c).ToString(), string.Empty);
            return returnString;
        }
        
        public static int answerPart2()
        {
            string inputString = getInputString();

            string reactedString = fullyReactString(inputString);
            int reducedLength = reactedString.Length;
            
            foreach (char c in setOfChars(reactedString))
            {
                string removedString = removeChar(reactedString, c);
                int removedReducedLength = fullyReactString(removedString).Length;
                if (removedReducedLength < reducedLength)
                {
                    reducedLength = removedReducedLength;
                }
            }

            return reducedLength;  // should be 6942
        }
        
        static void Main(string[] args)
        {
            Console.WriteLine(answerPart1());
            Console.WriteLine(answerPart2());
        }
    }
}