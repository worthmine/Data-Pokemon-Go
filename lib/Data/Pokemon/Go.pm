package Data::Pokemon::Go;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.14";

use Moose;

1;
__END__

=encoding utf-8

=head1 NAME

Data::Pokemon::Go - Data for every Pokemon in Pokemon Go

=head1 SYNOPSIS

 use utf8;
 use Data::Pokemon::Go::Pokemon;
 my $pg = Data::Pokemon::Go::Pokemon->new( name => 'カイリュー' );
 print $pg->effective();    # こおり ドラゴン いわ フェアリー
 print $pg->invalid();      # くさ みず むし じめん ほのお かくとう
 print $pg->advantage();    # はがね でんき いわ
 print $pg->disadvantage(); # むし かくとう ドラゴン くさ
 print $pg->recommended();  # こおり いわ フェアリー

 use Data::Pokemon::Go::IV;
 my $iv = Data::Pokemon::Go::IV->new();
 print $iv->_calculate_CP( name => $pg->name(), LV => 20, ST => 15, AT => 15, DF => 15 );
 # 2167

=head1 DESCRIPTION

Data::Pokemon::Go is the helper module for who has less knowledge about Pokemons

=head1 TODO

=over

=item supporting Multi-language is not completely

=item YAML for after Unova Region are not available

=item Japanese documents are not available L<qiitaで日本語解説を少しだけ|https://qiita.com/worthmine/items/4a51fd74f31b4a97cf3c>

=back

I can't support all of the above with just only me alone.
So, please L<PR|https://github.com/worthmine/Data-Pokemon-Go/pulls>!

=head1 LICENSE

Copyright (C) Yuki Yoshida.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Yuki Yoshida E<lt>worthmine@gmail.comE<gt>

=cut
