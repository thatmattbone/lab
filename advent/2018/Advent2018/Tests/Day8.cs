using Xunit;
using Day8;

namespace Tests
{
    public class Day8Tests
    {
        [Fact]
        public void TestDay8Part1()
        {
            Assert.Equal(ProgramDay8.answerPart1(), -1);
        }

        [Fact]
        public void TestDay8Part2()
        {
            Assert.Equal(ProgramDay8.answerPart2(), -2);
        }

//        [Theory]
//        [InlineData("A", 61)]
//        [InlineData("B", 62)]
//        [InlineData("Z", 86)]
//        public void TestSecondsForInstructionName(string name, int seconds)
//        {
//            Assert.Equal(seconds, ProgramDay7.secondsForInstructionName(name));
//        }
    }
}