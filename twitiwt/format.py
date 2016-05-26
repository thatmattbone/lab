from collections import defaultdict

stats = defaultdict(int)

for line in open('new_out.dat'):
    if(line.startswith('Error')):
        continue
    else:        
        stats[line.strip()] += 1

reports = stats.items()
reports.sort(key=lambda x: -1 * x[1])

n= []
for row in reports[:30]:
    print('"%s","%s"' % (row[0], row[1]))
    #n.append(row[1])

#def normList(L, normalizeTo=1):
#    '''normalize values of a list to make its max = normalizeTo'''

#    vMax = max(L)
#    return [ x/(vMax*1.0)*normalizeTo for x in L]

#labels = ["t%s" % row[0] for row in reports[:30]]

#normed = normList(n, normalizeTo=100)
#print """http://chart.apis.google.com/chart?cht=bhs&chs=500x325&chd=t:%s&chm=%s""" % (",".join([str(i) for i in normed]),
#                                                                                      "|".join(labels))

