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
            using (StreamReader sr = new StreamReader(INPUT_PATH))
            {
                string intStr;
                while ((intStr = sr.ReadLine()) != null)
                {
                    int valueFromFile = stringToInt(intStr);
                    Console.WriteLine(valueFromFile);    
                }
                /*byte[] b = new byte[1024];
                UTF8Encoding temp = new UTF8Encoding(true);
                while (fs.Read(b,0,b.Length) > 0)
                {
                    string numString = temp.GetString(b);
                    if (numString != "")
                    {
                        Console.WriteLine(numString);
                        Console.WriteLine("numString");
                        int num = stringToInt(numString);
                        
                    }
                }
                */                
            }
        }
    }
}