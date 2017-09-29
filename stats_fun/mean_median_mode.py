from __future__ import print_function
import numpy
#import pandas as pd
#import pprint

# map from values to frequency
data1 = {1: 4,
         2: 6,
         3: 4,
         4: 4,
         5: 3,
         6: 2,
         7: 1,
         8: 1}

data2 = {1: 1,
         4: 1,
         6: 2,
         8: 3,
         9: 4,
         10: 4,
         11: 5}


def freq_map_to_list(freq_map):
    """
    Convert a map from values-> frequency to just a list of values.
    """
    values = []
    for value, frequency in freq_map.iteritems():
        values.extend([value] * frequency)
    return values


if __name__ == '__main__':
    #TODO find the mean, median and mode of data1, data2
    data1_npy = numpy.array(freq_map_to_list(data1))
    print("Data 1: {}".format(data1_npy))
    print("Mean: {}".format(data1_npy.mean()))
    print("Median: {}".format(numpy.median(data1_npy)))

    data2_npy = numpy.array(freq_map_to_list(data2))
    print("Data 2: {}".format(data2_npy))
    print("Mean: {}".format(data2_npy.mean()))
    print("Median: {}".format(numpy.median(data2_npy)))
