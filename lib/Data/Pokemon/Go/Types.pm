package Data::Pokemon::Go::Types;
use 5.008001;
use utf8;

use Moose;
use Moose::Util::TypeConstraints;

our @All = qw(
    ノーマル かくとう どく じめん ひこう むし いわ
    ゴースト はがね ほのお みず でんき くさ こおり
    エスパー ドラゴン あく フェアリー
);

enum 'Type' => \@All;
has types       => ( is => 'ro', default => 'ノーマル', isa => 'Type' );
has effective   => ( is => 'rw', default => sub{[]}, isa => 'ArrayRef[Type]' );
has invalid     => ( is => 'rw', default => sub{[]}, isa => 'ArrayRef[Type]' );
has void        => ( is => 'rw', default => sub{[]}, isa => 'ArrayRef[Type]' );

__PACKAGE__->meta->make_immutable;
no Moose;

1;
__END__

=encoding utf-8

=head1 NAME

Data::Pokemon::Go::Relaition - It's new $module

=head1 SYNOPSIS

    use Data::Pokemon::Go::Relaition;

=head1 DESCRIPTION

Data::Pokemon::Go::Relaition is ...

=head1 LICENSE

Copyright (C) Yuki Yoshida.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Yuki Yoshida E<lt>worthmine@gmail.comE<gt>

=cut

