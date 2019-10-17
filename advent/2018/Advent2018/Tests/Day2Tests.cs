using System;
using Xunit;
using Day2;

namespace Tests
{
    public class UnitTest2
    {
        [Fact]
        public void TestDay2Part1()
        {
            Assert.Equal(7776, ProgramDay2.answerPart1());
        }
        
        [Fact]
        public void TestDay2Part2()
        {
            Assert.Equal("wlkigsqyfecjqqmnxaktdrhbz", ProgramDay2.answerPart2());
        }
        
    }
}