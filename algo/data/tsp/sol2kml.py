#!/usr/bin/env python
# -*- coding: utf-8 -*-

import re
import sys

sol_file = sys.argv[1]
coords_file = sys.argv[2]
coords = dict()

for line in open(coords_file):
    l = line[:-1].decode('utf-8').split('\t')
    coords[l[0]] = (float(l[1]), float(l[2]))

sol = open(sol_file).read().decode('utf-8')[:-1]
re1 = re.compile(u'(?:\d+:)?([\w\. ]*)\((\d+)\)', re.UNICODE)
tsp = []
sol_p = sol.split('>')
sol_p.append(sol_p[0]);
markers = ''
polyline = ''
i=0
for c in sol_p:
    m = re1.match(c);
    lat = '%4.4f' % coords[m.group(1)][0]
    lng = '%4.4f' % coords[m.group(1)][1]
    polyline += '  new google.maps.LatLng(' + lat + ',' + lng + '),\n'
    markers +=  '{ lat: ' + lat + ', lng: ' + lng + ', name: "' + m.group(1) + '", pos:' + str(i) + ', km:' + m.group(2) + '},\n'
    i += 1
print 'var polylinePath = [\n', polyline, '];'
print 'var markers = [\n', markers.encode('utf-8'), '];'

