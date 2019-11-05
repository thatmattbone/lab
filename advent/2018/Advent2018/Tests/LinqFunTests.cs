using System;
using System.Collections.Generic;
using System.Linq;
using Utils;
using Xunit;


namespace Tests
{
    struct TestStruct
    {
        public int foo;
        public int bar;
    }

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
            int[] myIntArray = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

            Assert.Equal(
                new List<int> {1},
                myIntArray.Where(x => x == 1).ToList());
            
            var foo = from myInt in myIntArray where myInt == 1 select myInt;
            
            Assert.Equal(
                new List<int> {1},
                foo.ToList()
            );
            
            TestStruct[] myObjectArray =
            {
                new TestStruct {foo = 1, bar = 2},
                new TestStruct {foo = 1, bar = 3},
                new TestStruct {foo = 1, bar = 4}
            };
            
            Assert.Equal(
                new List<TestStruct> {
                    new TestStruct {foo = 1, bar = 2},
                    new TestStruct {foo = 1, bar = 4}},
                myObjectArray.Where(x => x.bar % 2 == 0).ToList()
            );
        }

        [Fact]
        public void TestLinqGroupBy()
        {
            TestStruct[] myObjectArray =
            {
                new TestStruct {foo = 1, bar = 2},
                new TestStruct {foo = 1, bar = 3},
                new TestStruct {foo = 2, bar = 4}
            };
            
            Dictionary<int, List<TestStruct>> myStructHisto = new Dictionary<int, List<TestStruct>>();
            myStructHisto[1] = new List<TestStruct>
            {
                new TestStruct {foo = 1, bar = 2},
                new TestStruct {foo = 1, bar = 3},
            };
            
            myStructHisto[2] = new List<TestStruct>
            {
                new TestStruct {foo = 2, bar = 4}
            };

            var foo = myObjectArray
                .GroupBy(x => x.foo)
                .ToDictionary(x => x.Key, x => x.ToList());
            Assert.Equal(
                myStructHisto,
                foo
            );
        }
    }
}