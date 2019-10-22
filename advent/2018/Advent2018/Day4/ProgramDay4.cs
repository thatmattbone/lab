using System.IO;
using System;
using System.Collections;
using System.Collections.Generic;

namespace Day4
{
    public struct GuardLog
    {
        public DateTime timestamp;
        public string action;
        public string orginalLine;
    }
    public class ProgramDay4
    {
        private static string INPUT_PATH = "/home/mbone/Developer/lab/advent/2018/Advent2018/Day4/input";
        private static string SORTED_INPUT_PATH = "/home/mbone/Developer/lab/advent/2018/Advent2018/Day4/sorted_input";

        static IEnumerable<string> fileToStringStream(string input_path)
        {
            using (StreamReader sr = new StreamReader(input_path))
            {
                string myStr;
                while ((myStr = sr.ReadLine()) != null)
                {
                    yield return myStr;
                }
            }
        }

        static List<GuardLog> sortInputFile()
        {
            List<GuardLog> guardLogs = new List<GuardLog>();
            
            foreach (string s in fileToStringStream(INPUT_PATH))
            {
                string datePart = s.Substring(1, 16);
                string rest = s.Substring(19);

                var guardLog = new GuardLog();
                guardLog.timestamp = DateTime.Parse(datePart);
                guardLog.action = rest;
                guardLog.orginalLine = s;

                guardLogs.Add(guardLog);
            }

            guardLogs.Sort((guard1, guard2) => guard1.timestamp.CompareTo(guard2.timestamp));
            
            return guardLogs;
        }

        static void writeGuardLogs(List<GuardLog> guardLogs)
        {
            using (StreamWriter sw = new StreamWriter(SORTED_INPUT_PATH))
            {
                foreach (var guardLog in guardLogs)
                {
                    sw.WriteLine(guardLog.orginalLine);
                }
            }
        }
        
        static void Main(string[] args)
        {
            writeGuardLogs(sortInputFile());
        }
    }
}