using System;
using System.Collections.Generic;
using Utils;

namespace Day6
{
    public struct BoardEntry
    { 
        public string name; 
        public (int, int) coords;
    }
    
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

        public static (int, int) getMaxes(List<(int, int)> coords)
        {
            int maxX = -1;
            int maxY = -1;

            foreach (var coord in coords)
            {
                maxX = coord.Item1 > maxX ? coord.Item1 : maxX;
                maxY = coord.Item2 > maxY ? coord.Item2 : maxY;
            }

            return (maxX, maxY);
        }

        public static (int, int) getMins(List<(int, int)> coords)
        {
            int minX = Int32.MaxValue;
            int minY = Int32.MaxValue;

            foreach (var coord in coords)
            {
                minX = coord.Item1 < minX ? coord.Item1 : minX;
                minY = coord.Item2 < minY ? coord.Item2 : minY;
            }

            return (minX, minY);
        }

        public static List<(int, int)> getNormalizedCoords()
        {
            var coords = getCoords();
            var min = getMins(coords);

            var normalizedCoords = new List<(int, int)>(coords.Count);

            foreach (var coord in coords)
            {
                var normalizedCoord = (coord.Item1 - min.Item1, coord.Item2 - min.Item2);
                normalizedCoords.Add(normalizedCoord);
            }

            return normalizedCoords;
        }

        public static int manhattanDistance((int, int) point1, (int, int) point2)
        {
            var d1 = point1.Item1 - point2.Item1;
            var d2 = point1.Item2 - point2.Item2;

            return Math.Abs(d1) + Math.Abs(d2);
        }
        
        public static int answerPart1()
        {
            var coords = getNormalizedCoords();
            var max = getMaxes(coords);
            
            List<int>[,] board = new List<int>[max.Item1, max.Item2];

            for (var i = 0; i < max.Item1; i++)
            {
                for (var j = 0; j < max.Item2; j++)
                {
                    board[i, j] = new List<int>();
                }
            }

            foreach (var coord in getNormalizedCoords())
            {
                for (var i = 0; i < max.Item1; i++)
                {
                    for (var j = 0; j < max.Item2; j++)
                    {
                        board[i, j].Add(manhattanDistance(coord, (i, j)));
                    }
                }
            }
            
            //Console.WriteLine(max);
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

            var foo = new HashSet<string>();
            
            var stringNames = Streams.NamedStrings().GetEnumerator();
            for (var i = 0; i < 1000; i++)
            {
                stringNames.MoveNext();
                var current = stringNames.Current;
                
                if (foo.Contains(current))
                {
                    throw new Exception("fuck " + current);
                }
                Console.WriteLine(current);
                foo.Add(current);
            }
        }
    }
}