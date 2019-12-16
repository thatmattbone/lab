using System;
using System.Collections.Generic;
using Utils;
using System.Linq;
using System.Text.RegularExpressions;

namespace Day8
{
    public class ProgramDay8
    {
        public static string INPUT_PATH = "/home/mbone/Developer/lab/advent/2018/Advent2018/Day8/input";

        public static int sumMetadata(int[] tree)
        {
            if (tree.Length == 0)
            {
                return 0;
            }
            string treeString = "";
            foreach (var i in tree)
            {
                treeString += " " + i;
            }
            Console.WriteLine("tree = " + treeString);            

            int numChildren = tree[0];
            int numMetadata = tree[1];
            //Console.WriteLine("num metadata: " + numMetadata);
            
            int sumOfOurMetadata = tree[^numMetadata..].Sum();
            //Console.WriteLine("sum metadata: " + sumOfOurMetadata);

            string recurSlice = "";
            foreach (var i in tree[2..^numMetadata])
            {
                recurSlice += " " + i;
            }
            //Console.WriteLine("sum metadata slice = " + recurSlice);

            return sumOfOurMetadata + sumMetadata(tree[2..^numMetadata]);
        }
        
        public static int answerPart1()
        {
            return sumMetadata(new int[] {2, 3, 0, 3, 10, 11, 12, 1, 1, 0, 1, 99, 2, 1, 1, 2}, 1);
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