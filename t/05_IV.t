use utf8;
use strict;
use warnings;

use Test::More 1.302 tests => 7;
use Test::More::UTF8;

use YAML::XS;
use File::Share 'dist_dir';
my $dir = dist_dir('Data-Pokemon-Go');

use lib './lib';
use Data::Pokemon::Go::Pokemon;
my $pg = Data::Pokemon::Go::Pokemon->new();

use_ok 'Data::Pokemon::Go::IV';                                         # 1
my $IV = new_ok 'Data::Pokemon::Go::IV';                                # 2

subtest 'Kanto'     => sub{ IVs('Kanto') };                             # 3
subtest 'Johto'     => sub{ IVs('Johto') };                             # 4
subtest 'Hoenn'     => sub{ IVs('Hoenn') };                             # 5
subtest 'Sinnoh'    => sub{ IVs('Sinnoh') };                            # 6
subtest 'Alola'     => sub{ IVs('Alola') };                             # 7

done_testing();

exit;

sub IVs {
    my $region = shift;
    my $data = YAML::XS::LoadFile("$dir/$region.yaml");
    my @pokemons = map{ Data::Pokemon::Go::Pokemon::_get_fullname( $_, 'ja' ) } @$data;
    plan tests => scalar @pokemons * 2;
    foreach my $name (@pokemons) {
        next unless $pg->exists($name);
        $pg->name($name);
        note $pg->name . "は" . join( '／', @{$pg->types()} ) . "タイプ";
        note '種族値は';
        note 'HPが' . $pg->stamina();
        note '攻撃が' . $pg->attack();
        note '防御が' . $pg->defense();
        my $CP;
        if ( $pg->isNotAvailable() ) {
            $CP = $IV->_calculate_CP( name => $name, LV => 40, ST => 15, AT => 15, DF => 15 );
            note "MAX成長時の個体値完璧の時のCPは$CP";
            is $CP, $pg->max('Grown'), "calculate CP for $name is ok";
            ok( 1, "${\$name}は未実装のポケモンのため検算を省略します。" );
        }else{
            $CP = $IV->_calculate_CP( name => $name, LV => 20, ST => 15, AT => 15, DF => 15 );
            note "孵化時の個体値完璧の時のCPは$CP";
            is $CP, $pg->max('Hatched'), "calculate CP for $name is ok";
            $CP = $IV->_calculate_CP( name => $name, LV => 25, ST => 15, AT => 15, DF => 15 );
            note "ブースト時の個体値完璧の時のCPは$CP";
            is $CP, $pg->max('Boosted'), "calculate CP for $name is ok";
        }
    }
};
