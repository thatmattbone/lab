using System;
using System.Collections.Generic;
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

        public static IEnumerable<object[]> stringToHistoTestData
        {
            get
            {
                return new[]
                {
                    new object[] {"aaa", new Dictionary<char, int> {{'a', 3}}},
                    new object[] {"aab", new Dictionary<char, int> {{'a', 2}, {'b', 1}}}
                };
            }
        }
        
        [Theory]
        [MemberData(nameof(stringToHistoTestData))]
        public void TestStringToHisto(string input, Dictionary<char, int> histo)
        {
            Assert.Equal(histo, ProgramDay2.stringToHisto(input));
        }
        
    }
}