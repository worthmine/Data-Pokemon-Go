[![Build Status](https://travis-ci.com/worthmine/Data-Pokemon-Go.svg?branch=master)](https://travis-ci.com/worthmine/Data-Pokemon-Go) [![MetaCPAN Release](https://badge.fury.io/pl/Data-Pokemon-Go.svg)](https://metacpan.org/release/Data-Pokemon-Go)
# NAME

Data::Pokemon::Go - Data for every Pokemon in Pokemon Go

# SYNOPSIS

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

# DESCRIPTION

Data::Pokemon::Go is the helper module for who has less knowledge about Pokemons

# TODO

- supporting Multi-language is not completely
- YAML for after Unova Region are not available
- Japanese documents are not available [qiitaで日本語解説を少しだけ](https://qiita.com/worthmine/items/4a51fd74f31b4a97cf3c)

I can't support all of the above with just only me alone.
So, please [PR](https://github.com/worthmine/Data-Pokemon-Go/pulls)!

# LICENSE

Copyright (C) Yuki Yoshida.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Yuki Yoshida <worthmine@gmail.com>
