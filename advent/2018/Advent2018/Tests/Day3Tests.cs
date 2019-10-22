using System;
using System.Collections.Generic;
using Xunit;
using Day3;

namespace Tests
{
    public class Day3Tests
    {
        [Fact]
        public void StubTest()
        {
            Assert.Equal(1, 1);
        }
        
        [Theory]
        [InlineData("#8 @ 101,902: 13x24", 8, 101, 902, 13, 24)]
        [InlineData("#15 @ 955,88: 11x10", 15, 955, 88, 11, 10)]
        public void TestLineToFabricPach(string line, int id, int x, int y, int width, int height)
        {
            var patch = ProgramDay3.lineToFabricPatch(line);
            Assert.Equal(patch.id, id);
            Assert.Equal(patch.x, x);
            Assert.Equal(patch.y, y);
            Assert.Equal(patch.width, width);
            Assert.Equal(patch.height, height);
        }
    }
}