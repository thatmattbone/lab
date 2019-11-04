using System.Collections.Generic;
using System.Linq;
using Utils;
using Xunit;


namespace Tests
{
    public class LinqFunTests
    {
        [Fact]
        public void TestHistogramWithInts()
        {
            int[] myInts = {1, 1, 1, 2, 2, 4};
            var histogram = LinqFun.GetHistogram(myInts);
            
            Assert.Equal(
                new Dictionary<int, int>{{1, 3}, {2, 2}, {4, 1}},
                histogram);
        }
        
        [Fact]
        public void TestHistogramWithStrings()
        {
            string[] myInts = {"one", "one", "one", "two", "two", "four"};
            var histogram = LinqFun.GetHistogram(myInts);
            
            Assert.Equal(
                new Dictionary<string, int>{{"one", 3}, {"two", 2}, {"four", 1}},
                histogram);
        }

        [Fact]
        public void TestLinqSelections()
        {
            int[] myArray = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

            Assert.Equal(
                new List<int> {1},
                myArray.Where(x => x == 1).ToList());
            
            var foo = from myInt in myArray where myInt == 1 select myInt;
            
            Assert.Equal(
                new List<int> {1},
                foo.ToList()
            );
        }
    }
}