package Data::Pokemon::Go::Relation::Single;
use 5.008001;
use Carp;

use Moose;
use Moose::Util::TypeConstraints;

use Data::Pokemon::Go::Types;

use Path::Tiny;
use YAML::XS;

# initialize ==============================================================

my $relation = path( 'data', 'Advantage.yaml' );
my $ref_advantage = YAML::XS::LoadFile($relation);

my $datas = {};
my $relations = {};
while( my( $type, $ref ) = each %$ref_advantage ){
    while( my( $relation, $values ) = each %$ref ){
        next unless ref $values;
        push @{$datas->{$type}{void}}, @$values if $relation eq 'advantage';
        push @{$datas->{$type}{invalid}}, @$values if $relation eq 'valid';
        push @{$datas->{$type}{effective}}, @$values if $relation eq 'disadvantage';

        foreach my $value (@$values){
             push @{$relations->{$value}{invalid}}, $type
            if $relation eq 'advantage' or $relation eq 'valid';
             push @{$relations->{$value}{effective}}, $type
            if $relation eq 'disadvantage';

        }
    }
}

# accessor methods ========================================================

subtype 'Types' => as 'ArrayRef[Type]';
coerce 'Types'
    => from 'Type'
    => via {[$_]};
has types => ( is => 'ro', isa => 'Types', coerce => 1, required => 1 );

__PACKAGE__->meta->make_immutable;
no Moose;

# subroutine ==============================================================

sub effective {
    my $self = shift;
    my $type = $self->types()->[0];
    my $data = $relations->{$type};
    return @{ $data->{effective} } if $data->{effective};
    return;
}

sub invalid {
    my $self = shift;
    my $type = $self->types()->[0];
    my $data = $relations->{$type};
    my @list = @{ $data->{invalid} || [] };
    unshift @list, @{ $data->{void} } if $data->{void};
    return @list if @list;
    return;
}

sub advantage {
    my $self = shift;
    my $type = $self->types()->[0];
    my $data = $ref_advantage->{$type};
    my @list = @{ $data->{valid} || [] };
    unshift @list, @{ $data->{advantage} || [] };
    my $i = 0;
    foreach my $value (@list) {
        foreach my $type ( $self->invalid() ){
            splice @list, $i, 1 if $type eq $value;
        }
        $i++;
    }
    return @list;
}

sub disadvantage {
    my $self = shift;
    my $type = $self->types()->[0];
    my $data = $ref_advantage->{$type};
    return @{ $data->{disadvantage} || [] };
}

sub recommend {
    my $self = shift;
    my @recommend = ();
    foreach my $type1 ( $self->effective() ){
        foreach my $type2 ( $self->advantage() ){
            push @recommend, $type1 if $type1 && $type2 and $type1 eq $type2;
        }
    }
    return @recommend if @recommend;

    @recommend = $self->effective(), $self->advantage();
    for( my $i = 0; $i <= @recommend; $i++ ) {
        next unless $recommend[$i];
        foreach my $type ( $self->disadvantage() ) {
            splice @recommend, $i, 1 if $type eq $recommend[$i];
        }
    }
    return @recommend;
}

1;
__END__

=encoding utf-8

=head1 NAME

Data::Pokemon::Go::Relation::Single - It's new $module

=head1 SYNOPSIS

    use Data::Pokemon::Go::Relation::Single;

=head1 DESCRIPTION

Data::Pokemon::Go::Relation::Single is ...

=head1 LICENSE

Copyright (C) Yuki Yoshida.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Yuki Yoshida E<lt>worthmine@gmail.comE<gt>

=cut

