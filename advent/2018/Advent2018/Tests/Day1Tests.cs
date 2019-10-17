using System;
using Xunit;
using Day1;

namespace Tests
{
    public class Day1Test
    {
        [Fact]
        public void TestDay1Part1UsingList()
        {
            Assert.Equal(466, ProgramDay1.answer1UsingList());
        }

        [Fact]
        public void TestDay1Part1UsingStream()
        {
            Assert.Equal(466, ProgramDay1.answer1UsingStream());
        }
        
        [Fact]
        public void TestDay1Part2()
        {
            Assert.Equal(750, ProgramDay1.answer2UsingStream());
        }
    }
}