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
            guardId = -1;
            actions = new List<GuardLog>();
            isAwake = new bool[60]; // isAwake[0] is true if guard is awake in minute 0, etc, all the way to minute 59
            for (var i = 0; i < 60; i++)
            {
                this.isAwake[i] = true;
            }
        }

        /**
         * Return the total number of seconds this guard has been asleep during this shift.
         *
         * Max of 60 possible.
         */
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

        /**
         * Given a starting minute and an isAwakeVal, set the rest of the isAwake array (i.e. isAwake[minute] to
         * isAwake[59] to the isAwakeVal.
         */
        private void setRest(int minute, bool isAwakeVal)
        {
            for (var i = minute; i < 60; i++)
            {
                this.isAwake[i] = isAwakeVal;
            }
        }

        /**
         * Using the GuardACtions in this.actions, populate the isAwake array. 
         */
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

    public class ProgramDay4FileSorter
    {
        public static List<GuardLog> sortInputFile()
        {
            List<GuardLog> guardLogs = new List<GuardLog>();
            
            foreach (string s in Streams.fileToStringStream(ProgramDay4.INPUT_PATH))
            {
                guardLogs.Add(ProgramDay4.stringToGuardLog(s));
            }

            guardLogs.Sort((guard1, guard2) => guard1.timestamp.CompareTo(guard2.timestamp));
            
            return guardLogs;
        }

        public static void writeGuardLogs(List<GuardLog> guardLogs)
        {
            using (StreamWriter sw = new StreamWriter(ProgramDay4.SORTED_INPUT_PATH))
            {
                foreach (var guardLog in guardLogs)
                {
                    sw.WriteLine(guardLog.orginalLine);
                }
            }
        }
        
    }
    
    public class ProgramDay4
    {
        public static string INPUT_PATH = "/home/mbone/Developer/lab/advent/2018/Advent2018/Day4/input";
        public static string SORTED_INPUT_PATH = "/home/mbone/Developer/lab/advent/2018/Advent2018/Day4/sorted_input";
        
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

        public static GuardLog stringToGuardLog(string log)
        {
            string datePart = log.Substring(1, 16);
            string rest = log.Substring(19);

            var guardLog = new GuardLog();
            guardLog.timestamp = DateTime.Parse(datePart);
            guardLog.orginalLine = log;
            (guardLog.action, guardLog.guardId) = actionStringToGuardAction(rest);
            return guardLog;
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
                            currentShift.populateIsAwake();
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
            var guardShifts = buildGuardShifts(Streams.fileToStringStream(SORTED_INPUT_PATH).Select(stringToGuardLog)).ToList();
            var guardIdToTotalAsleepTime = guardShifts
                .GroupBy(guardShift => guardShift.guardId)
                .ToDictionary(
                    grouping => grouping.Key,
                    grouping => grouping.Select(guardShift => guardShift.asleepTotal()).Sum());
            
            var guardIdToShifts = guardShifts
                .GroupBy(guardShift => guardShift.guardId)
                .ToDictionary(grouping => grouping.Key, grouping => grouping.ToList());

            int guardId = -1;
            int maxSleep = 0;
            foreach (var entry in guardIdToTotalAsleepTime)
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

            foreach (var shift in guardIdToShifts[guardId])
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
            //ProgramDay4FileSorter.writeGuardLogs(ProgramDay4FileSorter.sortInputFile());
            
            Console.WriteLine(answerPart1());
            Console.WriteLine(answerPart2());
        }
    }
}