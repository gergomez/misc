#!/usr/bin/perl -w

use Data::Dumper;
use Storable;
my %tree;
my @cp;
my ($tsize, $Lsize, $Lfilename, $total, $nfiles);
my ($last, $lastname);
$tsize = 0;

$salida = shift;

if(! $salida) {
    $salida = 'salida.STORABLE';
}

while(<>) {
    chop;
    if(m#^\./(.*)\:#) {
        @cp = split('/', $1);
        $tsize = $Lsize = $nfiles = 0;
        $Lfilename = $last = '';
        next;
    }
    if(/^total (\d+)$/) {
        $total = $1;
        next;
    }

    if(/^\s*$/) {  # Salto de linea -> rellenamos info
        my $p = \%tree;
        foreach my $t (@cp) {
            if(!exists($p->{$t})) {
                #print "Creando ($t)\n";
                $p->{$t} = {
                    '/total' => 0,
                    '/size' => 0,
                    '/Lsize' => 0,
                    '/Lfilename' => '',
                    '/last' => '',
                    '/lastname' => '',
                    '/nfiles' => 0,
                    '/nfilesm' => 0,
                };
            }
            $p->{$t}->{'/total'} += $total;
            $p->{$t}->{'/size'} += $tsize;
            $p->{$t}->{'/nfiles'} += $nfiles;
            if($Lsize > $p->{$t}->{'/Lsize'}) { 
                $p->{$t}->{'/Lsize'} = $Lsize;
                $p->{$t}->{'/Lfilename'} = $Lfilename;
            }
            if($nfiles > $p->{$t}->{'/nfilesm'}) {
                $p->{$t}->{'/nfilesm'} = $nfiles;
            }
            if($last gt $p->{$t}->{'/last'}) {
                $p->{$t}->{'/last'} = $last;
                $p->{$t}->{'/lastname'} = $lastname;
            }
            #print join('/', @cp) . " : ($t) Total: " . $p->{$t}->{'/total'} . "\n";
            $p = $p->{$t};
        }
        next;
    }
#    if(/^[rwxs-]{10}\s+\d+\s+\w+\s+\w+\s+(\d+)\s+(\w+)\s+(\w+)\s+([0-9:]+)\s+(.*)$/) {
    if(/^[rwxs-]{10}\s+\d+\s+\w+\s+\w+\s+(\d+)\s+([\w\-]+)\s+([0-9:]+)\s+(.*)$/) {
        my $size = $1;
        my $date = "$2 $3";
        my $filename = $4;
        if($size > $Lsize) {
            $Lsize = $size;
            $Lfilename = join('/', @cp) . '/' . $filename;
        }
        if($date gt $last) {
            $last = $date;
            $lastname = join('/', @cp) . '/' . $filename;
        }
        $tsize += $size;
        ++$nfiles;
        #print "-->$_\nSize: '$size'\nDate: '$date'\nHour_Year: '$hour_year'\nFilename: '$filename'\n\n";
        next;
    }
    if(/^[dl]/) { # Nos saltamos los directorios 
        ++$nfiles; # aunque cuentan como ficheros
        next;
    }
    print STDERR "No se procesar '$_'\n";
}

store(\%tree, $salida);

#my %tree2 = %{retrieve($salida)};
#my %tree2 = %{retrieve("/bin/gzip -dc $salida | ")};
#print Dumper(%tree2);
