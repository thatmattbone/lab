using System.IO;
using System;
using System.Collections;
using System.Collections.Generic;
using Utils;
using System.Text.RegularExpressions;
using System.Linq;

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

    public class GuardShift
    {
        public int guardId;
        public List<GuardLog> actions;
        public bool[] isAwake;

        public GuardShift()
        {
            this.guardId = -1;
            this.actions = new List<GuardLog>();
            this.isAwake = new bool[60];
            for (var i = 0; i < 60; i++)
            {
                this.isAwake[i] = true;
            }
        }

        public int asleepTotal()
        {
            var total = 0;
            for (var i = 0; i < 60; i++)
            {
                if (!isAwake[i])
                {
                    total++;
                }
            }

            return total;
        }

        private void setRest(int minute, bool isAwakeVal)
        {
            for (var i = minute; i < 60; i++)
            {
                this.isAwake[i] = isAwakeVal;
            }
        }

        public void populateIsAwake()
        {
            foreach (var action in this.actions)
            {
                var hour = action.timestamp.Hour;
                var minute = action.timestamp.Minute;

                if (hour == 23)
                {
                    minute = 0;
                }

                if (action.action == GuardAction.FallsAsleep)
                {
                    setRest(minute, false);    
                }
                else
                {
                    setRest(minute, true);
                }
            }
        }
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

        public static IEnumerable<GuardShift> buildGuardShifts(IEnumerable<GuardLog> guardLogs)
        {
            GuardShift currentShift = null;

            foreach (var guardLog in guardLogs)
            {
                switch (guardLog.action)
                {
                    case GuardAction.BeginsShift:
                        
                        if (currentShift != null)
                        {
                            yield return currentShift;    
                        }
                        currentShift = new GuardShift();
                        currentShift.guardId = guardLog.guardId;

                        break;
                    
                    case GuardAction.FallsAsleep:
                    case GuardAction.WakesUp:
                        currentShift.actions.Add(guardLog);
                        break;
                }
            }
        }

        public static int answerPart1()
        {
            var guardLogs = Streams.fileToStringStream(SORTED_INPUT_PATH).Select(stringToGuardLog);

            var guardHash = new Dictionary<int, int>();
            var guardToShifts = new Dictionary<int, List<GuardShift>>(); 
            foreach (var guardShift in buildGuardShifts(guardLogs))
            {
                guardShift.populateIsAwake();

                if (!guardHash.ContainsKey(guardShift.guardId))
                {
                    guardHash[guardShift.guardId] = 0;
                    guardToShifts[guardShift.guardId] = new List<GuardShift>();
                }
                guardHash[guardShift.guardId] += guardShift.asleepTotal();
                
                guardToShifts[guardShift.guardId].Add(guardShift);
            }

            int guardId = -1;
            int maxSleep = 0;
            foreach (var entry in guardHash)
            {
                if (entry.Value > maxSleep)
                {
                    guardId = entry.Key;
                    maxSleep = entry.Value;
                } 
            }

            int[] mostAsleep = new int[60];
            for (var i = 0; i < 60; i++)
            {
                mostAsleep[i] = 0;
            }

            foreach (var shift in guardToShifts[guardId])
            {
                for (var i = 0; i < 60; i++)
                {
                    if (!shift.isAwake[i])
                    {
                        mostAsleep[i] += 1;
                    }
                }
            }
            var foo = mostAsleep.Select((n, i) => (Number: n, Index: i)).Max();
            return guardId * foo.Index;
        }

        public static int answerPart2()
        {
            var guardLogs = Streams.fileToStringStream(SORTED_INPUT_PATH).Select(stringToGuardLog);

            var guardHash = new Dictionary<int, List<int>>();
            
            foreach (var guardShift in buildGuardShifts(guardLogs))
            {
                guardShift.populateIsAwake();

                if (!guardHash.ContainsKey(guardShift.guardId))
                {
                    guardHash[guardShift.guardId] = new List<int>();
                }

                for (var i = 0; i < 60; i++)
                {
                    if (!guardShift.isAwake[i])
                    {
                        guardHash[i].Add(guardShift.guardId);    
                    }
                }
            }

            int maxGuardId = -1;
            int maxSleepMinute = -1;

            foreach (var item in guardHash)
            {
                var foo = item.Value.GroupBy(i => i).OrderByDescending(i => i).First();
                Console.WriteLine(foo);
            }

            return maxGuardId * maxSleepMinute;
        }

        
        static void Main(string[] args)
        {
            //writeGuardLogs(sortInputFile());
            Console.WriteLine(answerPart1());
            Console.WriteLine(answerPart2());
        }
    }
}