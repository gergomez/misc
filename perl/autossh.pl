#!/usr/bin/perl
use Net::SSH::Expect;
use Term::ReadKey;
use strict;

sub help {
    die("Uso: autossh.pl <user> <hosts_file> <commands_file>\n");
}

my $user = shift or help;
my $hosts = shift or help;
my $cmds = shift or help;

my $debug = 1;

my $password_root ;
print "password (root): ";
ReadMode('noecho');
chomp(($password_root) = ReadLine(0));
ReadMode('normal');
print("\n");

open CMDS, "<$cmds";

my @cmds;
while(<CMDS>) {
    chomp;
    push(@cmds, $_);
}

close CMDS;

open HOSTS, "<$hosts";

my $PROMPT = '[\$%#>] $';
my $TIMEOUT = 300;

while(<HOSTS>) {
    if(/^\s*#/) {
        next;
    }
    chomp;
    my $host = $_;
    my $ssh = Net::SSH::Expect->new (
            host => $host,
            user => $user,
            raw_pty => 1
    );
    print "*** CONNECTING TO '$host' ***\n" if $debug;
    if(!$ssh->run_ssh()) {
        print "SSH process couldn't start: $!\n";
        next;
    }

    if(!($ssh->read_all(5) =~ /$PROMPT/)) {
        print "Prompt not found\n";
        next;
    }

    # disable terminal translations and echo on the SSH server
    # executing on the server the stty command:
    $ssh->exec("stty raw -echo");

    print "*** BECOMING ROOT ***\n" if $debug;
    $ssh->send("su -");
    if(!$ssh->waitfor('Password:\s*$', $TIMEOUT)) {
        print "Error in 'su -' (1)\n";
        next;
    }
    $ssh->send($password_root);
    if(!$ssh->waitfor($PROMPT, $TIMEOUT)) {
        print "Error in 'su -' (2)\n";
        next;
    }

    foreach my $cmd (@cmds) {
        next if($cmd =~ m/^\s*#/);
        my $cmd2 = sprintf($cmd, $host, $host, $host, $host, $host);
        print "*** RUNNING '$cmd2' ***\n" if $debug;
        $ssh->send("$cmd2\n");
        if($ssh->waitfor($PROMPT, $TIMEOUT)) {
            print $ssh->before() . "\n";
        } else {
            print "*** TIMEOUT RUNNING '$cmd2' ***\n";
            print $ssh->peek() . "\n";
            print "*** ABORTING ***\n";
            last;
        }
#        my $output = $ssh->exec($cmd);
#        print("$output\n");
    }
    # closes the ssh connection
    $ssh->close();
}
close(HOSTS);
