using Day7;
using Xunit;


namespace Tests
{
    public class Day7Tests
    {
        [Fact]
        public void TestDay7Part1()
        {
            Assert.Equal(ProgramDay7.answerPart1(), "CGKMUWXFAIHSYDNLJQTREOPZBV");
        }

        [Fact]
        public void TestDay7Part2()
        {
            Assert.Equal(ProgramDay7.answerPart2(), 1046);
        }

        [Theory]
        [InlineData("A", 61)]
        [InlineData("B", 62)]
        [InlineData("Z", 86)]
        public void TestSecondsForInstructionName(string name, int seconds)
        {
            Assert.Equal(seconds, ProgramDay7.secondsForInstructionName(name));
        }
    }
}