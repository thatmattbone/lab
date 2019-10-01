using System.Collections.Generic;

namespace Utils
{
    public static class Streams
    {
        public static IEnumerable<T> StreamForever<T>(this IEnumerable<T> inputStream)
        {
            while (true)
            {
                foreach (var i in inputStream)
                {
                    yield return i;
                }
            }
        }
       
    }
}