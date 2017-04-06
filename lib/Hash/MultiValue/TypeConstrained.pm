package Hash::MultiValue::TypeConstrained;
use 5.008001;
use strict;
use warnings;
use parent 'Hash::MultiValue';

use Carp;
use Mouse::Util::TypeConstraints;

our $VERSION = "0.01";

sub get_typed {
    my ($self, $type_spec, $name) = @_;
    my $constraint = Mouse::Util::TypeConstraints::find_or_parse_type_constraint($type_spec);
    Carp::croak("No spec defined: $type_spec") unless defined $constraint;
    Carp::croak("Type constraint must be concrete")
        if _is_arrayref($constraint) && (! defined $constraint->type_parameter);
    my $value =
        _is_arrayref($constraint) ?
        [ $self->get_all($name) ] :
        $self->get($name);
    return undef unless defined $value;
    return undef unless $constraint->check($value);
    return $value;
}

sub _is_arrayref {
    my ($tc) = @_;
    return ($tc->name eq 'ArrayRef') || ($tc->parent->name eq 'ArrayRef') ? 1 : 0;
}

1;
__END__

=encoding utf-8

=head1 NAME

Hash::MultiValue::TypeConstrained - It's new $module

=head1 SYNOPSIS

    use Hash::MultiValue::TypeConstrained;

=head1 DESCRIPTION

Hash::MultiValue::TypeConstrained is ...

=head1 LICENSE

Copyright (C) aereal.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

aereal E<lt>aereal@aereal.orgE<gt>

=cut

