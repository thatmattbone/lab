using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace Day3
{
    public struct FabricPatch
    {
        public int id;
        public int x;
        public int y;
        public int width;
        public int height;
    }
    
    public class ProgramDay3
    {
        private static string INPUT_PATH = "/home/mbone/Developer/lab/advent/2018/Advent2018/Day3/input";
        private static int FABRIC_SIZE = 1000;
        
        public static List<int>[,] BuildInitialFabric(int fabricSize)
        {
            List<int>[,] fabric = new List<int>[fabricSize, fabricSize];

            for (int i = 0; i < fabricSize; i++)
            {
                for (int j = 0; j < fabricSize; j++)
                {
                    fabric[i, j] = new List<int>();
                }
            }

            return fabric;
        }

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

        public static FabricPatch lineToFabricPatch(string line)
        {
            char[] firstSplitCharacters = {'@', ':'};
            string[] firstSplit = line.Split(firstSplitCharacters);

            char[] idTrimCharacters = {' ', '#'}; 
            int id = Int32.Parse(firstSplit[0].Trim(idTrimCharacters));

            string[] xYSplit = firstSplit[1].Split(',');
            int x = Int32.Parse(xYSplit[0].Trim());
            int y = Int32.Parse(xYSplit[1].Trim());

            string[] widthHeightSplit = firstSplit[2].Split('x');
            int width = Int32.Parse(widthHeightSplit[0].Trim());
            int height = Int32.Parse(widthHeightSplit[1].Trim());
            
            var patch = new FabricPatch();
            patch.id = id;
            patch.x = x;
            patch.y = y;
            patch.width = width;
            patch.height = height;
            return patch;
        }

        public static List<int>[,] BuildFabric()
        {
            var fabric = BuildInitialFabric(FABRIC_SIZE);
                        
            foreach (var s in fileToStringStream())
            {
                
                var patch = lineToFabricPatch(s);
                
                for (int i = 0; i < patch.width; i++)
                {
                    for (int j = 0; j < patch.height; j++)
                    {
                        int index1 = patch.x + i;
                        int index2 = patch.y + j;
                        fabric[index1, index2].Add(patch.id);
                    }
                }
            }

            return fabric;
        }

        public static int answerPart1()
        {
            var fabric = BuildFabric();

            int total = 0;
            for (int i = 0; i < FABRIC_SIZE; i++)
            {
                for (int j = 0; j < FABRIC_SIZE; j++)
                {
                    if (fabric[i, j].Count >= 2)
                    {
                        total++;
                    }
                }
            }

            return total;
        }

        public static int answerPart2()
        {
            var fabric = BuildFabric();
            
            foreach (var s in fileToStringStream())
            {
                
                var patch = lineToFabricPatch(s);

                var encounteredMismatch = false;
                for (int i = 0; i < patch.width; i++)
                {
                    for (int j = 0; j < patch.height; j++)
                    {
                        int index1 = patch.x + i;
                        int index2 = patch.y + j;
                        if (fabric[index1, index2].Count > 1)
                        {
                            encounteredMismatch = true;
                        }
                    }
                }

                if (!encounteredMismatch)
                {
                    return patch.id;
                }
            }

            return -1;
        }
        
        static void Main(string[] args)
        {
            Console.WriteLine(answerPart1());
            Console.WriteLine(answerPart2());
        }
    }
}