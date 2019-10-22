using System;
using System.Collections.Generic;
using System.IO;

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

        public static void answerPart1()
        {
            var fabric = BuildInitialFabric(1000);
                        
            foreach (var s in fileToStringStream())
            {
                var patch = lineToFabricPatch(s);
                Console.WriteLine(patch);
            }
            
        }
        
        static void Main(string[] args)
        {
            answerPart1();
        }
    }
}