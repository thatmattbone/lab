using System.IO;
using System;
using System.Collections;
using System.Collections.Generic;
using Utils;
using System.Text.RegularExpressions;
using  System.Linq;

namespace Day4
{
    public enum GuardAction
    {
        BeginsShift,
        FallsAsleep,
        WakesUp
    };
    
    public struct GuardLog
    {
        public DateTime timestamp;
        public GuardAction action;
        public int guardId;
        public string orginalLine;
    }
    
    public class ProgramDay4
    {
        private static string INPUT_PATH = "/home/mbone/Developer/lab/advent/2018/Advent2018/Day4/input";
        private static string SORTED_INPUT_PATH = "/home/mbone/Developer/lab/advent/2018/Advent2018/Day4/sorted_input";
        
        private static Regex beginShiftRegex = new Regex(@"Guard #(?<guardId>\d+) begins shift", RegexOptions.Compiled);
        
        static (GuardAction, int) actionStringToGuardAction(string action)
        {
            if (action == "wakes up")
            {
                return (GuardAction.WakesUp, -1);
            } else if (action == "falls asleep")
            {
                return (GuardAction.FallsAsleep, -1);
            } else
            {
                MatchCollection matches = beginShiftRegex.Matches(action);
                string guardIdString = matches[0].Groups["guardId"].Value;
                return (GuardAction.BeginsShift, Int32.Parse(guardIdString));
            }
        }

        static GuardLog stringToGuardLog(string log)
        {
            string datePart = log.Substring(1, 16);
            string rest = log.Substring(19);

            var guardLog = new GuardLog();
            guardLog.timestamp = DateTime.Parse(datePart);
            guardLog.orginalLine = log;
            (guardLog.action, guardLog.guardId) = actionStringToGuardAction(rest);
            return guardLog;
        }

        static List<GuardLog> sortInputFile()
        {
            List<GuardLog> guardLogs = new List<GuardLog>();
            
            foreach (string s in Streams.fileToStringStream(INPUT_PATH))
            {
                guardLogs.Add(stringToGuardLog(s));
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

        public static IEnumerable<GuardLog> populateGuardLogGuardIds(IEnumerable<GuardLog> guardLogs)
        {
            int currentGuard = -1;
            foreach (var guardLog in guardLogs)
            {
                var newGuardLog = new GuardLog();
                newGuardLog.timestamp = guardLog.timestamp;
                newGuardLog.orginalLine = guardLog.orginalLine;
                
                switch (guardLog.action)
                {
                    case GuardAction.BeginsShift:
                        currentGuard = guardLog.guardId;
                        
                        newGuardLog.guardId = currentGuard;
                        newGuardLog.action = GuardAction.BeginsShift;
                        
                        break;
                    
                    case GuardAction.WakesUp:
                        newGuardLog.guardId = currentGuard;
                        newGuardLog.action = GuardAction.WakesUp;
                        
                        break;
                        
                    case GuardAction.FallsAsleep:
                        newGuardLog.guardId = currentGuard;
                        newGuardLog.action = GuardAction.FallsAsleep;
                    
                        break;
                }

                yield return newGuardLog;
            }
        }

        public static int answerPart1()
        {
            var guardLogs = Streams.fileToStringStream(SORTED_INPUT_PATH).Select(stringToGuardLog);

            foreach (var guardLog in populateGuardLogGuardIds(guardLogs))
            {
                if (guardLog.guardId == -1)
                {
                    throw new Exception("fuck");
                }
            }

            return -1;
        }
        
        static void Main(string[] args)
        {
            //writeGuardLogs(sortInputFile());
            Console.WriteLine(answerPart1());
        }
    }
}