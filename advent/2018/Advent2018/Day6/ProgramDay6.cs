using System;
using System.Collections.Generic;
using Utils;

namespace Day6
{
    public class ProgramDay6
    {
        public static string INPUT_PATH = "/home/mbone/Developer/lab/advent/2018/Advent2018/Day6/input";

        public static List<(int, int)> getCoords()
        {
            var coords = new List<(int, int)>();

            foreach (string input in Streams.fileToStringStream(INPUT_PATH))
            {
                var splitInput = input.Split(",");
                coords.Add((Int32.Parse(splitInput[0]), Int32.Parse(splitInput[1])));
            }
            
            return coords;
        }
        
        public static int answerPart1()
        {
            foreach (var coord in getCoords())
            {
                Console.WriteLine(coord);
            }
            return -1;
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