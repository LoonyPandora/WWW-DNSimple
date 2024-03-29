package WWW::DNSimple;

# ABSTRACT: Perl interface to the dnsimple.com API

=head1 NAME

WWW::DNSimple - Perl interface to the dnsimple.com API

=head1 SYNOPSIS

=cut

our $VERSION = '0.0.1';

use strict;

use Moo;
use Type::Tiny;
use JSON::XS;
use Try::Tiny;

with "WWW::DNSimple::Role";


use WWW::DNSimple::Prices;
use WWW::DNSimple::Domains;


has prices => (
    is => 'rw',
    lazy => 1,
    default => sub {
        my $self = shift;
        return WWW::DNSimple::Prices->new($self->required_args);
    },
);

has domains => (
    is => 'rw',
    lazy => 1,
    default => sub {
        my $self = shift;
        return WWW::DNSimple::Domains->new($self->required_args);
    },
);




1;


=head1 MORE INFORMATION

=head2 Purpose

=head2 Rationale

=head2 Configuration


=head1 KNOWN ISSUES


=head1 SEE ALSO


=head1 AUTHOR

James Aitken <jaitken@cpan.org>


=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by James Aitken.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
