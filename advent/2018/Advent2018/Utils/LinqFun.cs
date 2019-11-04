using System.Collections;
using System.Collections.Generic;
namespace Utils
{
    public class LinqFun
    {
        public static Dictionary<T, int> GetHistogram<T>(IEnumerable<T> inputDict)
        {
            Dictionary<T, int> histogram = new Dictionary<T, int>();

            foreach (var item in inputDict)
            {
                if (histogram.ContainsKey(item))
                {
                    histogram[item] += 1;
                }
                else
                {
                    histogram[item] = 1;
                }
            }

            return histogram;
        }
    }
}