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
            Assert.Equal(ProgramDay5.answerPart1(), 9704);
        }

        [Fact]
        public void TestDay5Part2()
        {
            Assert.Equal(ProgramDay5.answerPart2(), 6942);
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

        [Theory]
        [InlineData("dabAaCBAcaDA", "dabAcCaCBAcCcaDA")]
        [InlineData("stxPsEy", "stxPsEy")]
        public void TestReactString(string expected, string input)
        {
            Assert.Equal(expected, ProgramDay5.reactString(input));
        }

        [Theory]
        [InlineData("fbar", "foobar", 'o')]
        [InlineData("fbar", "fOobar", 'o')]
        [InlineData("fbar", "fOObar", 'o')]
        public void TestRemoveChar(string expected, string input, char removeChar)
        {
            Assert.Equal(expected, ProgramDay5.removeChar(input, removeChar));
            Assert.Equal(expected, ProgramDay5.removeChar(input, char.ToUpper(removeChar)));
        }
    }
}