using System;
using System.IO;
using System.Text;

namespace Day1
{
    class Program
    {
        private static string INPUT_PATH = "/home/mbone/Developer/lab/advent/2018/Advent2018/Day1/input";
        
        static int stringToInt(string inputString)
        {
            return Int32.Parse(inputString);
        }
        
        static void Main(string[] args)
        {
            int i = 99;
            var j = -50;
            
            using (FileStream fs = File.OpenRead(INPUT_PATH))
            {
                byte[] b = new byte[1024];
                UTF8Encoding temp = new UTF8Encoding(true);
                while (fs.Read(b,0,b.Length) > 0)
                {
                    Console.WriteLine(temp.GetString(b));
                }                
            }
        }
    }
}