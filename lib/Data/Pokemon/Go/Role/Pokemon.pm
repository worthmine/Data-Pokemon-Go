package Pokemon::Go::Role::Pokemon;
use 5.008001;

use Moose;
with 'Pokemon::Go::Role::Types';

use Pokemon::Go::Skill;

requires qw(name types skills);

=cut

has name    => ( is => 'ro', default => '', isa => 'Str' );
has id      => ( is => 'ro', default => 1,  isa => 'Int' );
has CP      => ( is => 'ro', default => 10, isa => 'Int' );
has HP      => ( is => 'ro', default => 1,  isa => 'Int' );
has AP      => ( is => 'ro', default => 1,  isa => 'Int' );
has DP      => ( is => 'ro', default => 1,  isa => 'Int' );

has types   => ( is => 'ro', default => sub{[]}, isa => 'Types' );
has skills  => ( is => 'ro', default => sub{[]}, isa => 'ArrayRef[Pokemon::Go::Skill]' );

=cut

1;
__END__

=encoding utf-8

=head1 NAME

Pokemon::Go::Relaition - It's new $module

=head1 SYNOPSIS

    use Pokemon::Go::Relaition;

=head1 DESCRIPTION

Pokemon::Go::Relaition is ...

=head1 LICENSE

Copyright (C) Yuki Yoshida.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Yuki Yoshida E<lt>worthmine@gmail.comE<gt>

=cut

