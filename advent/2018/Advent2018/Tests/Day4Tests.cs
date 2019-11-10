using Xunit;
using Day4;

namespace Tests
{
    public class Day4Tests
    {
        [Fact]
        public void TestDay4Part1()
        {
            
            Assert.Equal(35184, ProgramDay4.answerPart1());
        }

        [Fact]
        public void TestDay4Part2()
        {
            Assert.Equal(37886, ProgramDay4.answerPart2());
        }
    }
}