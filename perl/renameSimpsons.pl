#!/usr/bin/perl

use HTML::TableExtract;
use Data::Dumper;

$te = new HTML::TableExtract;
$te->parse_file("list.simpsons");

my @tables = $te->tables;

my %codes;

for (my $i = 2; $i < (23 + 2); ++$i) {
    @rows = $tables[$i]->rows;
    for(my $j = 1; $j < @rows; ++$j) {
        my $n = $tables[$i]->cell($j, 1);
        my $code = $tables[$i]->cell($j, 3);
        $codes{$code} = $n;
    }
}

while(<>) {
    chop;
    my $file = $_;
    $file =~ m#./(\d\d)/(\d\d)-([A-Z0-9]+)-(.*).avi#;
    my $season = $1;
    my $code = $3;
    my $title = $4;

    if(!defined($codes{$code})) {
        print "#FALTA $code\n";
    } else {
        my $n = sprintf("%02d", $codes{$code});
        print "mv -i \"$file\" \"./$season/$n $title [$code].avi\"\n";
    }
}


