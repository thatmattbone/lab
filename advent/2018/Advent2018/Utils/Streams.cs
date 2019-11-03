using System.Collections.Generic;
using System.IO;

namespace Utils
{
    public static class Streams
    {
        public static IEnumerable<string> fileToStringStream(string inputPath)
        {
            using (StreamReader sr = new StreamReader(inputPath))
            {
                string myStr;
                while ((myStr = sr.ReadLine()) != null)
                {
                    yield return myStr;
                }
            }
        }

        
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