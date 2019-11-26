using System;
using System.Collections.Generic;
using Utils;
using System.Linq;
using System.Linq.Expressions;
using System.Text.RegularExpressions;

namespace Day7
{

    public struct Instruction
    {
        public string step;
        public string dependsOn;
    }

    
    public class ProgramDay7
    {
        public static string INPUT_PATH = "/home/mbone/Developer/lab/advent/2018/Advent2018/Day7/input";

        // Step I must be finished before step E can begin.
        private static Regex instructionRegex = new Regex(@"Step (?<dependsOn>\w) must be finished before step (?<step>\w) can begin.", RegexOptions.Compiled);        
        
        public static IEnumerable<Instruction> getInstructions()
        {
            foreach (string instructionString in Streams.fileToStringStream(INPUT_PATH))
            {
                MatchCollection matches = instructionRegex.Matches(instructionString);

                var instruction = new Instruction();
                instruction.step = matches[0].Groups["step"].Value;
                instruction.dependsOn = matches[0].Groups["dependsOn"].Value;
                
                yield return instruction;
            }
        } 
        
        
        public static int answerPart1()
        {
            foreach (Instruction i in getInstructions())
            {
                Console.Write(i);
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