#!/usr/bin/perl
$n=0;
while (<>) {
    if (($t,$a,$l,$o) = (/^[^a-zA-Z]*ACPI: ([-._A-Z0-9]{4,4}) +([0-9a-f]{16,16}) ([0-9A-F]{5,5})+(?:\s*\(([^)]+))?/)) {
        $o && $o=~s/[^-._a-zA-Z0-9]+/-/g;
        print "acpidump -a $a -l $l > \"ACPI/${t}".($o?"_$o":"").".aml\"\n";
        ++$n;
    }
}
die("No match") unless $n;
