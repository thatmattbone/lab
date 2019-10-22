using System;
using System.Collections.Generic;

namespace Day3
{
    class ProgramDay3
    {

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
        
        static void Main(string[] args)
        {
            var fabric = BuildInitialFabric(1000);
            
            fabric[10, 10].Add(0);
            fabric[10, 10].Add(1);
            
            Console.WriteLine(fabric[1, 2].Count);
            Console.WriteLine(fabric[10, 10].Count);
        }
    }
}