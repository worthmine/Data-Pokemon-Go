use strict;
use Test::More 0.98 tests => 1;
use Test::More::UTF8;

use lib './lib';
use Data::Pokemon::Go::Pokemon qw($All);
my $pg = Data::Pokemon::Go::Pokemon->new();

SKIP: {
    skip "Not local", 1 unless $ENV{'USER'} eq 'yuki.yoshida';

    my @list = ();
    foreach (@Data::Pokemon::Go::Pokemon::All){
        my $name = $pg->get_Pokemon_name( $All->{$_}, 'ja' );
         push @list, [ $name, 1, 1, 1, '名詞', '固有名詞', 'ポケモン', '*', '*', '*', $name, $name, $name ]
        unless scalar @list and $list[-1][0] eq $name;
    }

    require Text::CSV_XS;
    my $csv = Text::CSV_XS->new({ binary => 1, quote_char => undef });
    open my $fh2, ">:encoding(utf8)", "share/MeCab.csv" or die "Couldn't open CSV: $!";
    map{ $csv->say( $fh2, $_ ) } @list;
    close $fh2 or die "Couldn't write CSV: $!";

    is -e "share/MeCab.csv", 1, "Succeed to create share/MeCab.csv";        # 2
}

done_testing();
