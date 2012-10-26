#!/usr/bin/perl -w

while(<>) {
    while(m#(ed2k://.*?/)#g) {
        print "$1\n";
    }
}
