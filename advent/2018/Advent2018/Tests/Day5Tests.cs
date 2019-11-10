using Xunit;
using Day5;
using Microsoft.VisualStudio.TestPlatform.TestHost;

namespace Tests
{

    public class Day5Tests
    {
        [Fact]
        public void TestDay5Part1()
        {
            Assert.Equal(ProgramDay5.answerPart1(), "uh oh");
        }

        [Fact]
        public void TestDay5Part2()
        {
            Assert.Equal(ProgramDay5.answerPart2(), -2);
        }

        [Theory]
        [InlineData(false, 'a', 'b')]
        [InlineData(false, 'a', 'a')]
        [InlineData(false, 'A', 'A')]
        [InlineData(false, 'A', 'B')]
        [InlineData(false, 'A', 'b')]
        [InlineData(false, 'a', 'B')]
        [InlineData(true, 'a', 'A')]
        [InlineData(true, 'A', 'a')]
        [InlineData(true, 'c', 'C')]
        [InlineData(true, 'C', 'c')]
        public void TestWillReact(bool willReact, char first, char second)
        {
            Assert.Equal(willReact, ProgramDay5.willReact(first, second));
        }
    }
}