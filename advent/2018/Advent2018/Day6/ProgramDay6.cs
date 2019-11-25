using System;
using System.Collections.Generic;
using Utils;
using System.Linq;
using System.Linq.Expressions;

namespace Day6
{
    public struct BoardEntry
    { 
        public string name; 
        public (int, int) coord;
        public int distance;
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
            
            // initialize the board
            List<BoardEntry>[,] board = new List<BoardEntry>[max.Item1, max.Item2];
            for (var i = 0; i < max.Item1; i++)
            {
                for (var j = 0; j < max.Item2; j++)
                {
                    board[i, j] = new List<BoardEntry>();
                }
            }

            // brute force calculate the distance from everything...
            var coordNames = Streams.NamedStrings().GetEnumerator();
            foreach (var coord in coords)
            {
                coordNames.MoveNext();
                var coordName = coordNames.Current;
                
                for (var i = 0; i < max.Item1; i++)
                {
                    for (var j = 0; j < max.Item2; j++)
                    {
                        var boardEntry = new BoardEntry();
                        boardEntry.coord = coord;
                        boardEntry.name = coordName;
                        boardEntry.distance = manhattanDistance(coord, (i, j));
                        
                        board[i, j].Add(boardEntry);
                    }
                }
            }

//            for (var i = 0; i < max.Item1; i++)
//            {
//                for (var j = 0; j < max.Item2; j++)
//                {
//
//                }
//            }

            for (var i = 0; i < max.Item1; i++)
            {
                for (var j = 0; j < max.Item2; j++)
                {
                    board[i, j].Sort((x, y) => x.distance - y.distance);
                }
            }

            // ban the names at the edges of the board
            var banned = new HashSet<string>();
            for (var i = 0; i < max.Item1; i++)
            {
                banned.Add(board[i, 0][0].name);
                banned.Add(board[i, max.Item2-1][0].name);
            }
            for (var j = 0; j < max.Item2; j++)
            {
                banned.Add(board[0, j][0].name);
                banned.Add(board[max.Item1-1, j][0].name);
            }

            var nameCounter = new Dictionary<string, int>();
            for (var i = 0; i < max.Item1; i++)
            {
                for (var j = 0; j < max.Item2; j++)
                {
                    var entry = board[i, j];
                    if (entry[0].distance != entry[1].distance && !banned.Contains(entry[0].name))
                    {
                        var name = entry[0].name;
                        if (nameCounter.ContainsKey(name))
                        {
                            
                            nameCounter[name] += 1;
                        }
                        else
                        {
                            nameCounter[name] = 1;
                        }
                    }
                }
            }

            return nameCounter.Values.Max();
        }

        public static int answerPart2()
        {
            var coords = getNormalizedCoords();
            var max = getMaxes(coords);
            
            // initialize the board
            List<BoardEntry>[,] board = new List<BoardEntry>[max.Item1, max.Item2];
            for (var i = 0; i < max.Item1; i++)
            {
                for (var j = 0; j < max.Item2; j++)
                {
                    board[i, j] = new List<BoardEntry>();
                }
            }

            // brute force calculate the distance from every other coord...
            for (var i = 0; i < max.Item1; i++)
            {
                for (var j = 0; j < max.Item2; j++)
                {
                    foreach (var coord in coords)
                    {
                        var boardEntry = new BoardEntry();
                        boardEntry.coord = coord;
                        boardEntry.distance = manhattanDistance(coord, (i, j));
                    }
                }
            }

            int total = 0;
            for (var i = 0; i < max.Item1; i++)
            {
                for (var j = 0; j < max.Item2; j++)
                {
                    var entry = board[i, j];
                    var sum = entry.Select(x => x.distance).Sum();
                    if (sum < 10000)  // hardcoded limit from problem statement...
                    {
                        total += 1;
                    }
                }
            }
            
            // guessed 96408, was too high.
            return total;
        }
        
        static void Main(string[] args)
        {
            //Console.WriteLine(answerPart1());
            Console.WriteLine(answerPart2());
        }
    }
}