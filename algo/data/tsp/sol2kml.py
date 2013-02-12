#!/usr/bin/env python
# -*- coding: utf-8 -*-

import re

myre = re.compile(u'([^\d]*) ([\d]+)[^\d]+([\d]+)[^\d]+([\.\d]+)[^\d]+([NS]) ([\d]+)[^\d]+([\d]+)[^\d]+([\.\d]+)[^\d]+([WE])', re.UNICODE);

coords = dict()

for l in open('capitales.coord'):
    res = myre.match(l[:-1].decode('utf-8'))
    if not res: continue
    name = res.group(1)
    x = int(res.group(2)) + (float(res.group(3))/60 + float(res.group(4))/3600)
    if res.group(5) == 'S':
        x = -x

    y = int(res.group(6)) + (float(res.group(7))/60 + float(res.group(8))/3600)
    if res.group(9) == 'W':
        y = -y
    coords[name] = (x,y)

sol = open('sol.txt').read().decode('utf-8')[:-1]
myre = re.compile(u'(?:\d+:)?([\w\. ]*)\((\d+)\)', re.UNICODE)
tsp = []
sol_p = sol.split('>')
sol_p.append(sol_p[0]);
markers = ''
polyline = ''
i=0
for c in sol_p:
    res = myre.match(c);
    lat = '%4.4f' % coords[res.group(1)][0]
    lng = '%4.4f' % coords[res.group(1)][1]
    polyline += '  new google.maps.LatLng(' + lat + ',' + lng + '),\n'
    markers +=  '{ lat: ' + lat + ', lng: ' + lng + ', name: "' + res.group(1) + '", pos:' + str(i) + ', km:' + res.group(2) + '},\n'
    i += 1
print 'var polylinePath = [\n', polyline, '];'
print 'var markers = [\n', markers.encode('utf-8'), '];'

