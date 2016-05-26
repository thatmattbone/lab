#!/usr/bin/env python
# a stacked bar plot with errorbars
import numpy as np
import matplotlib.pyplot as plt

results = [('level', 662),
           ('kayak', 391),
           ('hannah', 179),
           ('kagak', 125),
           ('naman', 122),
           ('stats', 110),
           ('refer', 68),
           ('civic', 65),
           ('radar', 51),
           ('macam', 50),
           ('halah', 47),
           ('neden', 46),
           ('rever', 38),
           ('turut', 36),
           ('seres', 35),
           ('nahan', 29),
           ('nemen', 27),
           ('ketek', 19),
           ('madam', 17),
           ('merem', 15),
           ('matam', 14),
           ('tebet', 14),
           ('salas', 13),
           ('reconocer', 12),
           ('solos', 12),
           ('neben', 10),
           ('kutuk', 10),
           ('medem', 9),
           ('kenek', 9),
           ('racecar', 8)]

N = 5
labels   = [x[0] for x in results]
labels.reverse()
data = [x[1] for x in results]
data.reverse()
ind = np.arange(len(data))    # the x locations for the groups
width = 0.25       # the width of the bars: can also be len(x) sequence

p1 = plt.barh(ind, data, width, color='b')

plt.xlabel('Occurrence Over One Day')
plt.title('Twitter Palindromes (Top 30)')
plt.yticks(ind+width/2., labels)

plt.show()
