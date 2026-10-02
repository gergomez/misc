import argparse
import json
import os
import re
import subprocess
import sys


parser = argparse.ArgumentParser(
    prog='MKVFixer', description='Process and fix random MKV files'
)

parser.add_argument('file', nargs='*')
parser.add_argument('-d', '--default-forced', action='store_true', default=False)
parser.add_argument('-e', '--external-subs', action='store_true', default=False)
parser.add_argument('-s', '--disable-internal-subs', action='store_true', default=False)
parser.add_argument(
    '-f', '--disable-internal-forced', action='store_true', default=False
)
parser.add_argument('-c', '--disable-chapters', action='store_true', default=False)
parser.add_argument('-v', '--video-language', default='eng')
parser.add_argument(
    '-l', '--extra-languages', default='', help='Example: jpn:jp:Forced,rus:ru:Forced'
)

args = parser.parse_args()

EXTERNAL_SUBS = args.external_subs
DISABLE_INTERNAL_SUBS = args.disable_internal_subs
DISABLE_INTERNAL_FORCED = args.disable_internal_forced
DEFAULT_FORCED = args.default_forced

chapters = ''

langs = ['spa', 'eng']

subext = {'spa': 'es', 'eng': 'en'}

forced = {'spa': 'Forzados', 'eng': 'Forced'}

if args.extra_languages:
    for l in args.extra_languages.split(','):
        t = l.split(':')
        langs.append(t[0])
        if len(t) > 1:
            subext[t[0]] = t[1]
        else:
            subext[t[0]] = t[0][0:2]

        if len(t) > 2:
            forced[t[0]] = t[2]
        else:
            forced[t[0]] = 'Forced'

if args.disable_chapters:
    chapters = '--no-chapters'

for mkv in args.file:
    output = subprocess.run(
        ['mkvmerge', '-J', mkv], stdout=subprocess.PIPE
    ).stdout.decode('utf-8')
    file_info = json.loads(output)

    if 'tracks' not in file_info:
        print('Unable to process {}'.format(mkv))
        next

    vid = -1

    aid = {k: -1 for k in langs}
    sid = {k: -1 for k in langs}
    fid = {k: -1 for k in langs}

    for t in file_info['tracks']:
        if t['type'] == 'video' and (vid == -1 or t['properties']['default_track']):
            vid = t['id']
        if t['type'] == 'audio':
            lang = t['properties']['language']
            if lang not in langs:
                continue
            if aid[lang] < 0:
                aid[lang] = t['id']
        if t['type'] == 'subtitles':
            lang = t['properties']['language']
            if lang not in langs:
                continue
            for l in langs:
                if forced[l] in t['properties'].get('track_name', ''):
                    t['properties']['forced_track'] = True

            if t['properties']['forced_track'] or (
                DEFAULT_FORCED and t['properties']['default_track']
            ):
                if fid[lang] < 0 or (
                    t['properties']['codec_id'] == 'S_TEXT/UTF8'
                    and file_info['tracks'][fid[lang]]['properties']['codec_id']
                    != 'S_TEXT/UTF8'
                ):
                    fid[lang] = t['id']
            else:
                if sid[lang] < 0 or (
                    t['properties']['codec_id'] == 'S_TEXT/UTF8'
                    and file_info['tracks'][sid[lang]]['properties']['codec_id']
                    != 'S_TEXT/UTF8'
                ):
                    sid[lang] = t['id']

    if DISABLE_INTERNAL_FORCED:
        fid = {k: -1 for k in langs}

    if DISABLE_INTERNAL_SUBS:
        sid = {k: -1 for k in langs}

    cmd = 'mkvmerge -o "out/{mkv}" '.format(mkv=mkv)
    cmd += '--language {id}:{lang} --track-name {id}: '.format(
        id=vid, lang=args.video_language
    )
    tracks = [vid]
    for k in langs:
        if aid[k] >= 0:
            cmd += '--language {id}:{lang} --track-name {id}: '.format(
                id=aid[k], lang=k
            )
            tracks += [aid[k]]
    subs = False

    stracks = []
    for k in langs:
        if fid[k] >= 0:
            subs = True
            cmd += '--language {id}:{lang} --track-name {id}:"{forced}" '.format(
                id=fid[k], lang=k, forced=forced[k]
            )
            stracks += [fid[k]]
        if sid[k] >= 0:
            subs = True
            cmd += '--language {id}:{lang} --track-name {id}: '.format(
                id=sid[k], lang=k
            )
            stracks += [sid[k]]

    for track in tracks:
        cmd += '--default-track {id}:no --forced-track {id}:no '.format(id=track)
    for track in stracks:
        cmd += '--default-track {id}:no --forced-track {id}:no '.format(id=track)

    track_order = ','.join(["0:{}".format(x) for x in tracks])

    cmd_esubs = ''
    if EXTERNAL_SUBS:
        n = 1
        srt_file = mkv.replace('.mkv', '.srt')
        if os.path.exists(srt_file):
            track_order += ',{}:0'.format(n)
            n += 1
            cmd_esubs += (
                ' --language 0:spa --track-name 0:Forzados --default-track 0:no'
                ' --forced-track 0:no -s 0 -D -A -T --no-global-tags {chapters}'
                ' "{srt_file}" '.format(srt_file=srt_file, chapters=chapters)
            )

        for k in langs:
            srt_file = mkv.replace('.mkv', '.' + subext[k] + '.srt')
            if os.path.exists(srt_file):
                track_order += ',{}:0'.format(n)
                n += 1
                cmd_esubs += (
                    ' --language 0:{lang} --track-name 0:  --default-track 0:no'
                    ' --forced-track 0:no -s 0 -D -A -T --no-global-tags {chapters}'
                    ' "{srt_file}" '.format(
                        lang=k, srt_file=srt_file, chapters=chapters
                    )
                )

    cmd += '-d {} '.format(vid)
    cmd += '-a ' + ','.join([str(x) for x in aid.values() if x >= 0]) + ' '

    sublist = []
    if subs:
        sublist += [str(x) for x in fid.values() if x >= 0]
        sublist += [str(x) for x in sid.values() if x >= 0]
        cmd += '-s ' + ','.join(sublist) + ' '
        track_order += ',' + ','.join(["0:{}".format(x) for x in sublist])
    else:
        cmd += ' -S '

    cmd += ' -T --no-attachments --no-global-tags {chapters} "{mkv}" '.format(
        mkv=mkv, chapters=chapters
    )

    cmd += cmd_esubs

    cmd += (
        ' --track-order {track_order} --title "" --engage no_cue_duration --engage'
        ' no_cue_relative_position --clusters-in-meta-seek'
        ' --disable-track-statistics-tags '.format(track_order=track_order)
    )

    print(cmd)
