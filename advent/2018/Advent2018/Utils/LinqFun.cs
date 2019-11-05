using System.Collections;
using System.Collections.Generic;
using System.Linq;

namespace Utils
{
    public static class LinqFun
    {
        public static Dictionary<T, int> GetHistogram<T>(IEnumerable<T> inputDict)
        {
            return inputDict
                .GroupBy(x => x)
                .ToDictionary(x => x.Key, x => x.Count());
        }

        public static Dictionary<T, int> GetHistogramFromStream<T>(this IEnumerable<T> inputDict)
        {
            return GetHistogram(inputDict);
        }
    }
}
