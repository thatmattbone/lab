using Day6;
using Xunit;


namespace Tests
{
    public class Day6Tests
    {
        [Fact]
        public void TestDay6Part1()
        {
            Assert.Equal(ProgramDay6.answerPart1(), 4829);
        }

        [Fact]
        public void TestDay6Part2()
        {
            Assert.Equal(ProgramDay6.answerPart2(), 46966);
        }        
    }
}