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

overwrite = False
verbose = False


def usage():
    print '''usage: getlyrics.py [options]
    Retrieve lyrics for selected itunes song.
    Options:
        -h: show help
        -v: verbose
        -o: overwrite existing tags
        -p: priorty
            231: lyricmania.com, letras.mus.br, lyrics.wikia.com
            3: letras.mus.br
'''

# lyrics.wikia.com
def getlyrics1(artist, name):
    urlpath = artist + ':' + name
    urlpath = urlpath.replace(' ', '_')
    urlpath_ascii = urlpath.translate(toascii)
    # prefer Gracenote, so no set() to remove duplicates
    paths = ['Gracenote:'+urlpath, urlpath]
    if urlpath_ascii != urlpath:
        paths.extend(['Gracenote:'+urlpath.translate(toascii), urlpath.translate(toascii)])

    for p in paths:
        if verbose: print 'Trying wikia ' + p
        url = 'http://lyrics.wikia.com/' + p
        try:
            html = ''.join(urllib.urlopen(url.encode('utf-8')).readlines())
        except:
            if verbose: print 'Unable to connect'
            return None
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
    for p in set([path, path.translate(toascii)]):
        if verbose: print 'Trying lyricsmania ' + p
        url = 'http://www.lyricsmania.com/' + p + '.html'
        try:
            html = ''.join(urllib.urlopen(url.encode('utf-8')).readlines())
        except:
            if verbose: print 'Unable to connect'
            return None
        res = re.search("<div id='songlyrics_h' class='dn'>(.*?)</div>", html, re.S | re.I | re.U)
        if res:
            txt = res.group(1)
            while txt.find('&#') >= 0:
                txt = HTMLParser().unescape(txt)
            return txt.replace('<br />', '').decode('utf-8')
    return None


# letras.mus.br
def getlyrics3(artist, name):
    if verbose: print 'Trying letras.mus.br'
    url = 'http://letras.mus.br/' + artist.replace(' ', '-').lower() + '/'
    try:
        songs = ''.join(urllib.urlopen(url.encode('utf-8')).readlines())
    except:
        if verbose: print 'Unable to connect'
        return None
    res = re.search('<li><a href="([^"]*)">' + name + '</a></li>', songs, re.S | re.I | re.U)
    if not res:
        return None
    url = 'http://letras.mus.br' + res.group(1)
    try:
        html = ''.join(urllib.urlopen(url.encode('utf-8')).readlines())
    except:
        if verbose: print 'Unable to connect'
        return None
    res = re.search('<div id="div_letra" data-linhas="\d+">\s+(.*?)</div>',
                    html, re.S | re.I | re.U)
    if res:
        txt = res.group(1)
        while txt.find('&#') >= 0:
            txt = HTMLParser().unescape(txt)
        return txt.replace('<br/>', '').replace('<p>', '').replace('</p>', '').decode('utf-8')
    return None


try:
    opts, args = getopt.getopt(sys.argv[1:], 'hovp:', ['help', 'overwrite', 'verbose', 'priority='])
except getopt.GetoptError as err:
    print str(err)
    usage()
    sys.exit(2)

funcs = [getlyrics1,getlyrics2,getlyrics3]

for o, a in opts:
    if o in ('-o', '--overwrite'):
        overwrite = True
    elif o in ('-v', '--verbose'):
        verbose = True
    elif o in ('-p', '--priority'):
        tmp = []
        try:
            for i in a:
                tmp.append(funcs[int(i)-1])
        except:
            print 'Invalid argument'
            usage()
            sys.exit(2)
        funcs = tmp
    elif o in ('-h', '--help'):
        usage()
        sys.exit()
    else:
        assert False, 'unhandled option'

selection = app('itunes').selection.get()
n = 0

for song in selection:
    n += 1
    lyrics = None
    artist = song.artist()
    name = re.sub('\(.*?\)', '', song.name())
    name = ''.join(filter(lambda x: x.isalnum() or x in [',', '.', "'", '&'] or x.isspace(), name))
    print str(n) + ':' + artist + ":" + name,

    if song.lyrics() != '' and not overwrite:
        print ' -- Tag Present. Skipped --'
        continue
    if verbose: print

    for f in funcs:
        lyrics = f(artist, name)
        if lyrics: break

    if lyrics:
        print '-- ' + lyrics[:20] + '...'
        song.lyrics.set(lyrics)
    else:
        print ' -- Not Found --'
