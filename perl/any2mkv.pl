#!/usr/bin/perl
use File::Basename;
#use Encode;

$PROC_AUDIO = 1;
$PROC_AUDIO_STEREO = 1;
$X264='/cygdrive/c/bin/video/codecs/x264/x264-kmod.exe';
$FFMPEG='/cygdrive/c/bin/video/codecs/ffmpeg/x64/ffmpeg.exe';
$FFMPEG_AAC='/cygdrive/c/bin/video/codecs/ffmpeg/x64/ffmpeg-nonfree.exe';
$MKVMERGE='/cygdrive/c/bin/video/mkvtoolnix/mkvmerge.exe';
$file = shift or die;
$ofile = basename($file, ('.avi', '.mkv', '.mp4'));
#$ofile = Encode::decode('UTF-8', $ofile);
#$ofile =~ tr/ÁÉÍÓÚáéíóú/AEIOUaeiou/;
#$ofile = Encode::encode('UTF-8', $ofile);
$odir = dirname($file);
$c_mkvmerge = ''; 
$txt = qx(ls "$odir/$ofile"*.srt 2> /dev/null);
foreach (split /\n/, $txt) {
  if(/\.(en\.|es\.)?srt/) { 
    $lang = $1;
    if($lang eq '') {
      $c_mkvmerge .= "--track-name 0:\"Forzados\" --language 0:es \"$_\" ";
    } else {
      chop($lang);
      $c_mkvmerge .= "--language 0:$lang \"$_\" ";
    }
  }
} 
$c_procaudio = ' -map 0 -vn ';
$resize = '';
$txt = qx($FFMPEG -i "$file" 2>&1);
foreach (split /\n/, $txt) {
  if(/Stream #\d:(\d+).* Video: (.*?) .*, (\d+)x(\d+)[ ,]/) { 
    $n = $1; $type = $2; $res_x = $3; $res_y = $4;
    #print "$n:$type:$res_x:$res_y:$bitrate\n";
    if( $res_x > 720 ) {
        $resize = "--vf resize:720,,,width,,lanczos";
    }
  } elsif(/Stream #\d:(\d+).* Audio: (.*?) .*, (stereo|mono|5.1\(side\)), .*, (\d+) kb\/s/) { 
    $n = $1; $type = $2; $channels = $3; $bitrate = $4;
    --$n;
    #print "$n:$type:$channels:$bitrate\n";
    if ($channels eq '5.1(side)') {
      if($PROC_AUDIO_STEREO) {
        $tmp = " -c:a:$n libfdk_aac -b:a:$n 128k -ac:$n 2 ";
      } elsif($type eq 'ac3' and $bitrate < 400) {
        $tmp = " -c:a:$n copy ";
      } elsif ($type eq 'ac3' and $bitrate >= 400) {
        $tmp = " -c:a:$n libfdk_aac -b:a:$n 320k ";
      } else {
        $tmp = " -c:a:$n copy ";
      }
    } elsif ($type eq 'ac3') {
      $tmp = " -c:a:$n libfdk_aac -b:a:$n 128k ";
    } elsif ($type eq 'mp3' and $bitrate >= 128) {
      $tmp = " -c:a:$n libfdk_aac -b:a:$n 128k ";
    } elsif ($type eq 'mp3' and $bitrate < 128) {
      $tmp = " -c:a:$n libfdk_aac -b:a:$n 64k ";
    } else {
      $tmp = " -c:a:$n copy ";
    }
    $c_procaudio .= $tmp;
  }
} 

$c_x264 = "$X264 -o \"e:/tmp.mkv\" --crf 22 --ref 8 --bframes 5 --b-adapt 2 --b-pyramid strict --me umh --subme 9 --merange 32 --deblock -2,-1 $resize \"$file\"";
$c_mkvmerge = substr($c_mkvmerge, 0, -1);
if ($PROC_AUDIO) {
  $c_procaudio = "$FFMPEG_AAC -y -i \"$file\" $c_procaudio -c:s copy -movflags +faststart \"e:/audio.mkv\"";
  $c_mkvmerge = "$MKVMERGE --clusters-in-meta-seek --engage no_cue_duration --engage no_cue_relative_position -o \"H:/SERIES/$odir/$ofile.mkv\" -A -S \"e:/tmp.mkv\" --language 0:es --language 1:en -D \"e:/audio.mkv\" $c_mkvmerge";
} else {
  $c_procaudio = "true";
  $c_mkvmerge = "$MKVMERGE --clusters-in-meta-seek --engage no_cue_duration --engage no_cue_relative_position -o \"H:/SERIES/$odir/$ofile.mkv\" -A -S \"e:/tmp.mkv\" --language 1:es --language 2:en -D \"$file\" $c_mkvmerge";
}
print "$c_x264\n";
#system($c_x264);
print "$c_procaudio\n";
#system($c_procaudio);
print "$c_mkvmerge\n";
#system($c_mkvmerge);
