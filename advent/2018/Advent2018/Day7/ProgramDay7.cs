using System;
using System.Collections.Generic;
using Utils;
using System.Linq;
using System.Text.RegularExpressions;

namespace Day7
{

    public struct InstructionRecord
    {
        public string Step;
        public string DependsOn;
    }

    public class Instruction
    {
        public string Name { get; }
        private Dictionary<string, Instruction> WaitingOn { get; }
        public int SecsRemaining { get;  }
        public bool IsRunning { get; private set; }
        
        public Instruction(string name)
        {
            Name = name;
            WaitingOn = new Dictionary<string, Instruction>();
            SecsRemaining = ProgramDay7.secondsForInstructionName(name);
            IsRunning = false;
        }

        public void addInstructionToWaitOn(Instruction waitingOnInstruction)
        {
            if (WaitingOn.ContainsKey(waitingOnInstruction.Name))
            {
                throw new Exception("already have key: " + waitingOnInstruction.Name);
            }
            
            WaitingOn.Add(waitingOnInstruction.Name, waitingOnInstruction);
        }

        public void resolveInstruction(string instructionName)
        {
            if (WaitingOn.ContainsKey(instructionName))
            {
                WaitingOn.Remove(instructionName);
            }
        }

        public bool readyToRun()
        {
            if (WaitingOn.Count == 0)
            {
                return true;
            }

            return false;
        }
        
        public void startRunning()
        {
            IsRunning = true;
        }

        public bool stillRuning()
        {
            if (SecsRemaining == 0)
            {
                return false;
            }

            return true;
        }

        public override string ToString()
        {
            return Name;
        }
    }

    
    public class ProgramDay7
    {
        public static string INPUT_PATH = "/home/mbone/Developer/lab/advent/2018/Advent2018/Day7/input";

        // Step I must be finished before step E can begin.
        private static Regex instructionRegex = new Regex(@"Step (?<dependsOn>\w) must be finished before step (?<step>\w) can begin.", RegexOptions.Compiled);        
        
        public static IEnumerable<InstructionRecord> getInstructions()
        {
            foreach (string instructionString in Streams.fileToStringStream(INPUT_PATH))
            {
                MatchCollection matches = instructionRegex.Matches(instructionString);

                var instruction = new InstructionRecord();
                instruction.Step = matches[0].Groups["step"].Value;
                instruction.DependsOn = matches[0].Groups["dependsOn"].Value;
                
                yield return instruction;
            }
        }

        public static int secondsForInstructionName(string name)
        {
            return ((int) name[0]) - 4;
        }

        public static Dictionary<string, Instruction> buildInstructionList()
        {
            var nameToInstruction = new Dictionary<string, Instruction>();
            foreach (InstructionRecord i in getInstructions())
            {
                if (!nameToInstruction.ContainsKey(i.Step))
                {
                    nameToInstruction.Add(i.Step, new Instruction(i.Step));    
                }
                
                if (!nameToInstruction.ContainsKey(i.DependsOn))
                {
                    nameToInstruction.Add(i.DependsOn, new Instruction(i.DependsOn));    
                }

                var dependsOn = nameToInstruction[i.DependsOn];
                nameToInstruction[i.Step].addInstructionToWaitOn(dependsOn);
            }

            return nameToInstruction;
        }
        
        public static string answerPart1()
        {
            var nameToInstruction = buildInstructionList();
            var result = "";

            var readyToRunCount = (from instruction in nameToInstruction.Values
                where instruction.readyToRun()
                select instruction).Count();

            while (readyToRunCount > 0)
            {
                var nextInstruction = (from instruction in nameToInstruction.Values
                    where instruction.readyToRun()
                    orderby instruction.Name
                    select instruction.Name).First();

                nameToInstruction.Remove(nextInstruction);

                foreach (var instruction in nameToInstruction.Values)
                {
                    instruction.resolveInstruction(nextInstruction);
                }
                
                result += nextInstruction;
                
                readyToRunCount = (from instruction in nameToInstruction.Values
                    where instruction.readyToRun()
                    select instruction).Count();                
            }

            return result;
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