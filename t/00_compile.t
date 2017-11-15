use strict;
use Test::More 0.98;

use lib './lib';

use_ok('Data::Pokemon::Go::Pokemon');

unless( -s 'data/MeCab.csv' ) {
    require Text::CSV_XS;
    my $csv = Text::CSV_XS->new ({ binary => 1, quote_char => undef });
    open my $fh, ">:encoding(utf8)", 'data/MeCab.csv' or die "Couldn't open CSV: $!";
    $csv->say( $fh, $_ ) for map{
        [ $_, 1, 1, 1, '名詞', '固有名詞', 'ポケモン', '*', '*', '*', $_, $_, $_ ]
    } @Data::Pokemon::Go::Pokemon::All;
    close $fh or die "Couldn't write CSV: $!";
}

done_testing();
