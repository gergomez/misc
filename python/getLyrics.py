#!/usr/bin/python
# coding=utf-8
from HTMLParser import HTMLParser
import re
import urllib
import getopt
import sys

from appscript import app


intab = u'ÀÁÂÃÄÅàáâãäåÒÓÔÕÖØòóôõöøÈÉÊËèéêëÇçÌÍÎÏìíîïÙÚÛÜùúûüÿ'
outtab = u'AAAAAAaaaaaaOOOOOOooooooEEEEeeeeCcIIIIiiiiUUUUuuuuy'
toascii = dict((ord(a), b) for a, b in zip(intab, outtab))


def usage():
    print '''usage: getlyrics.py [options]
    Retrieve lyrics for selected itunes song.
    Options:
        -h: show help
        -o: overwrite existing tags'''


# lyrics.wikia.com
def getlyrics1(artist, name):
    urlpath = artist + ':' + name
    urlpath = urlpath.replace(' ', '_')
    for p in ['Gracenote:'+urlpath, urlpath, 'Gracenote:'+urlpath.translate(toascii), urlpath.translate(toascii)]:
        url = 'http://lyrics.wikia.com/' + p
        html = ''.join(urllib.urlopen(url.encode('utf-8')).readlines())
        if html.find('<meta name="description" content="Instrumental" />') >= 0:
            return 'Instrumental'
        res = re.search('height=\'17\'/></a></div>\s*(?:<p>)?(.*?)<!--\s*(?:<p>)?NewPP limit report', html,
                        re.S | re.I | re.U)
        if res:
            txt = res.group(1)
            while txt.find('&#') >= 0:
                txt = HTMLParser().unescape(txt)
            return txt.replace('<br />', '\n')
    return None


# www.lyricsmania.com
def getlyrics2(artist, name):
    path = name + '_lyrics_' + artist
    path = path.lower().replace(' ', '_')
    for p in [path, path.translate(toascii)]:
        url = 'http://www.lyricsmania.com/' + p + '.html'
        html = ''.join(urllib.urlopen(url.encode('utf-8')).readlines())
        res = re.search("<div id='songlyrics_h' class='dn'>(.*?)</div>", html, re.S | re.I | re.U)
        if res:
            txt = res.group(1)
            while txt.find('&#') >= 0:
                txt = HTMLParser().unescape(txt)
            return txt.replace('<br />', '').decode('utf-8')
    return None


# letras.mus.br
def getlyrics3(artist, name):
    url = 'http://letras.mus.br/' + artist.replace(' ', '-').lower() + '/'
    songs = ''.join(urllib.urlopen(url.encode('utf-8')).readlines())
    res = re.search('<li><a href="([^"]*)">' + name + '</a></li>', songs, re.S | re.I | re.U)
    if not res:
        return None
    url = 'http://letras.mus.br' + res.group(1)
    html = ''.join(urllib.urlopen(url.encode('utf-8')).readlines())
    res = re.search('<div id="div_letra" data-linhas="\d+">\s+(.*?)</div>',
                    html, re.S | re.I | re.U)
    if res:
        txt = res.group(1)
        while txt.find('&#') >= 0:
            txt = HTMLParser().unescape(txt)
        return txt.replace('<br/>', '').replace('<p>', '').replace('</p>', '').decode('utf-8')
    return None


try:
    opts, args = getopt.getopt(sys.argv[1:], 'ho', ['help', 'overwrite'])
except getopt.GetoptError as err:
    print str(err)
    usage()
    sys.exit(2)

overwrite = 0
for o, a in opts:
    if o in ('-o', '--overwrite'):
        overwrite = 1
    elif o in ('-h', '--help'):
        usage()
        sys.exit()
    else:
        assert False, 'unhandled option'

selection = app('itunes').selection.get()
n = 0

for song in selection:
    n += 1
    artist = song.artist()
    name = re.sub('\(.*?\)', '', song.name())
    name = ''.join(filter(lambda x: x.isalnum() or x in [',', '.', "'", '&'] or x.isspace(), name))
    print str(n) + ':' + artist + ":" + name,

    if song.lyrics() != '' and not overwrite:
        print ' -- Tag Present. Skipped --'
        continue
    lyrics = getlyrics1(artist, name)
    if not lyrics:
        lyrics = getlyrics2(artist, name)
    if not lyrics:
        lyrics = getlyrics3(artist, name)
    if lyrics:
        print '-- ' + lyrics[:20] + '...'
        song.lyrics.set(lyrics)
    else:
        print ' -- Not Found --'
