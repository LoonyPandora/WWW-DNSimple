package WWW::DNSimple::Prices;

# ABSTRACT: Perl interface to the prices section of the dnsimple.com API.

=head1 NAME

WWW::DNSimple::Prices - Perl interface to the prices section of the dnsimple.com API.

=head1 SYNOPSIS

=cut

use strict;
use Moo;

with "WWW::DNSimple::Role";


sub get_prices {
    my $self = shift;

    $self->query({
        method => "GET",
        path => "/prices",
    })
}





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
