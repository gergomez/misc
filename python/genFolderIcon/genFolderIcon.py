#!/usr/bin/python
#
# Set a folder icon based on a .app or .icns, convert to grayscale and center
# over generic folder icon.
#
# Use included plistlib (first version of new 3.4 version that support
# binary plist) http://bugs.python.org/issue14455
#
import plistlib
import re
from sys import argv
from tempfile import mkdtemp
import os
from shutil import rmtree

def usage():
    print "genFolderIcon.py <folder> [folder.app|icon.icns]"
    exit()

if len(argv) < 2:
    usage()

folder = argv[1]
if folder[-1] == '/':
    folder = folder[:-1]

if not os.path.isdir(folder):
    print 'error: folder not found'
    usage()

if len(argv) > 2 and argv[2][-5:] == '.icns':
    iconfile = argv[2]
else:
    if len(argv) == 2:
        app = folder + '/' + folder + '.app'
    else:
        app = argv[2]

    if not os.path.isdir(app):
        print 'error: app folder not found'
        usage()

    infoPlist = plistlib.readPlist(app + '/Contents/Info.plist')
    iconfile = infoPlist['CFBundleIconFile']
    if iconfile[-5:] != '.icns':
        iconfile += '.icns'
    iconfile = app + '/Contents/Resources/' + iconfile

tmpdir = mkdtemp()
os.system('iconutil -c iconset /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/GenericFolderIcon.icns -o ' + tmpdir + '/folder.iconset')
os.system('iconutil -c iconset "' + iconfile + '" -o ' + tmpdir + '/app.iconset')
os.mkdir(tmpdir + '/output.iconset')
cwd = os.getcwd()
os.chdir(tmpdir)
pattern = re.compile('icon_(\d+)x(\d+)(@2x)?\.png')
for f in os.listdir('app.iconset/'):
    match = pattern.match(f)
    height = int(match.group(2))
    if match.group(3): height *= 2
    os.system('convert app.iconset/' + f + ' -geometry 50% -colorspace Gray o.png')
    os.system('composite -gravity center -geometry +0+' + str(height/11) + ' o.png  folder.iconset/' + f + ' output.iconset/' + f)

os.system('iconutil -c icns output.iconset')
os.chdir(cwd)

from AppKit import NSWorkspace, NSImage
NSWorkspace.sharedWorkspace().setIcon_forFile_options_(NSImage.alloc().initWithContentsOfFile_(tmpdir + '/output.icns'),folder,0)
rmtree(tmpdir)
