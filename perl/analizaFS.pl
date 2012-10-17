#! /usr/bin/perl
use ExtUtils::testlib;
use Curses;
use Storable;
use Data::Dumper;


my $entrada = shift or die("Falta indicar el fichero de entrada (.gz)\n");
my $p = retrieve("gunzip -c $entrada |") or die("Imposible abrir $entrada");;
my $root = $p;

eval { new_menu() };
if ($@ =~ /not defined by your vendor/) {
    print STDERR "Curses was not compiled with menu support.\n";
    exit 1;
}


initscr;
noecho;

my $BASE_PREFIX = '/BASE';
my @ruta;

my @sortby = ('/size', '/nfiles', '/nfilesm', '/last', '/Lsize', '/');
my $sortbyid = 0;
my @extrafields = ('/Lfilename', '/lastname', '/total');

while(1) {
    my @il;
    my @pack;
    my $nochange;
    my $item;

    clrtobot(0, 0);
    refresh();
    attroff(A_BOLD);
    my $i = 0;
    addstr($i, 0, "$BASE_PREFIX/" . join('/', @ruta));
    if(@ruta > 0) {
        $item = new_item('..', '');
        push @il, new_item('..', '');
        push @pack, ${$item};
    }

    my @desc;
    my $j = 0;

    foreach my $I ((@sortby, @extrafields)) {
        if(! $p->{$I}) {
            next;
        }
        if($I eq $sortby[$sortbyid]) {
            attron(A_BOLD);
        } else {
            attroff(A_BOLD);
        }
        if($I eq '/Lsize' || $I eq '/size') {
            addstr(++$i, 0, "$I (" . tohuman($p->{$I}) . ")");
        } else {
            addstr(++$i, 0, "$I (" . $p->{$I} . ")");
        }
    }

    if($sortby[$sortbyid] ne '/') {
        foreach my $I (sort {$p->{$b}->{$sortby[$sortbyid]} <=> $p->{$a}->{$sortby[$sortbyid]}} keys %{$p}) {
            if($I =~ m#^/#) {
                next;
            }
            $desc[$j] = tohuman($p->{$I}->{'/size'}) . ' (' . $p->{$I}->{'/nfiles'} . '|' . $p->{$I}->{'/nfilesm'} .')';
            $item = new_item($I, $desc[$j++]);

            if ($item eq '') { fatal("new_item($I->[0], $I->[1]) failed: $item"); }
            push @il, $item;
            push @pack, ${$item};
        }
    } else {
        foreach my $I (sort keys %{$p}) {
            if($I =~ m#^/#) {
                next;
            }
            $desc[$j] = tohuman($p->{$I}->{'/size'}) . ' (' . $p->{$I}->{'/nfiles'} . '|' . $p->{$I}->{'/nfilesm'} .')';
            $item = new_item($I, $desc[$j++]);

            if ($item eq '') { fatal("new_item($I->[0], $I->[1]) failed: $item"); }
            push @il, $item;
            push @pack, ${$item};
        }
    }
    push @pack, 0;

    my $menu = new_menu(pack "L!*", @pack);
    if ($menu eq '') { fatal("new_menu failed") }

    my $rows;
    my $cols;
    set_menu_mark($menu, '->');
    set_menu_format($menu, 20, 1);
    scale_menu($menu, $rows, $cols);
    my $mwin = newwin($rows + 2, $cols + 2, 8, 25);
    my $msub = derwin($mwin, $rows, $cols, 1, 1);
    set_menu_win($menu, $mwin);
    set_menu_sub($menu, $msub);
    box($mwin, 0, 0);
    keypad($mwin, 1);
    post_menu($menu);
    refresh();

    my $ci;
    $nochange = 0;
    while(1) {
        my $ch = getch($mwin);
        if ($ch == KEY_UP) {
            menu_driver($menu, REQ_UP_ITEM);
        } elsif ($ch == KEY_DOWN) {
            menu_driver($menu, REQ_DOWN_ITEM);
        } elsif ($ch == KEY_PPAGE) {
            menu_driver($menu, REQ_SCR_UPAGE);
        } elsif ($ch == KEY_NPAGE) {
            menu_driver($menu, REQ_SCR_DPAGE);
        } elsif ($ch == KEY_HOME) {
            menu_driver($menu, REQ_FIRST_ITEM);
        } elsif ($ch == KEY_END) {
            menu_driver($menu, REQ_LAST_ITEM);
        } elsif (lc($ch) eq "s") {
            $sortbyid = ($sortbyid + 1) % @sortby;
            $nochange = 1;
            last;
        } elsif ($ch eq "\r" or $ch eq "\n") {
            $ci = current_item($menu);
            last;
        } elsif ($ch =~ /^\S$/) {
            menu_driver($menu, $ch);
        }
    }

    clrtoeol(1,0);
    if($nochange) {
        # No hacemos nada
    } elsif(item_name($ci) eq '..') {
        pop(@ruta);
        $p = $root;
        for(my $j = 0; $j < @ruta; ++$j) {
            $p = $p->{$ruta[$j]};
        }
    } else {
        $p = $p->{item_name($ci)};
        push(@ruta, item_name($ci));
    }
    refresh();

    unpost_menu($menu);
    delwin($mwin);
    free_menu($menu);
    map { free_item($_) } @il;
    endwin();
}

sub fatal {
    clrtobot(0, 0);
    addstr(0, 0, "@_\n");
    refresh();
    sleep 2;
    exit 1;
}

sub tohuman {
    my $n = shift or return '';
    $n = $n*1;
    my @sufijo = ('', 'K', 'M', 'G', 'T');
    my $i = 0;
    while($n > 1024) {
        $n /= 1024;
        ++$i;
    }
    $n =~ s/^(\d+)(\.\d{2})?.*$/$1$2/;
    my $salida = "$n " . $sufijo[$i];
    return $salida;
}
