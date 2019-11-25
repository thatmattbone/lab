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

        public static IEnumerable<string> NamedStrings()
        {
            string[] letters =
            {
                "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U",
                "V", "W", "X", "Y", "Z"
            };

            var nestedStrings = NamedStrings().GetEnumerator();
            while (true)
            {
                foreach (string i in letters)
                {
                    yield return i + nestedStrings.Current;
                }

                nestedStrings.MoveNext();
            }
        }
    }
}