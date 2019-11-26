using System;
using System.Collections.Generic;
using Utils;
using System.Linq;
using System.Linq.Expressions;
using System.Net;
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
        private string Name { get; }
        private SortedList<string, Instruction> dependents { get; }
        public Instruction DependsOn { get; private set; }
        
        public Instruction(string name)
        {
            Name = name;
            dependents = new SortedList<string, Instruction>();
            DependsOn = null;
        }

        public void addDependentInstruction(Instruction dependent)
        {
            dependents.Add(dependent.Name, dependent);

//            if (dependent.DependsOn != null)
//            {
//                throw new Exception("what");
//            }
            dependent.DependsOn = this;
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
        
        
        public static int answerPart1()
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
                
            }

            foreach (InstructionRecord i in getInstructions())
            {
                Instruction instruction = nameToInstruction[i.Step];
                Instruction dependsOn = nameToInstruction[i.DependsOn];
                
                dependsOn.addDependentInstruction(instruction);
            }

            foreach (var instruction in nameToInstruction.Values)
            {
                if (instruction.DependsOn == null)
                {
                    Console.WriteLine(instruction);
                }
            }
            return -1;
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