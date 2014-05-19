package WWW::DNSimple::Domains;

# ABSTRACT: Perl interface to the domains section of the dnsimple.com API.

=head1 NAME

WWW::DNSimple::Domains - Perl interface to the domains section of the dnsimple.com API.

=head1 SYNOPSIS

=cut

use strict;
use Moo;

with "WWW::DNSimple::Role";


# Gets a list of domains
sub get_domains {
    my $self = shift;

    $self->query({
        method => "GET",
        path => "/domains",
    })
}


# Gets a single domain
sub get_domain {
    my ($self, $domain) = @_;

    # TODO: Some better validation than it simply containing a dot
    unless ($domain =~ m/\.+/) {
        $self->throw("invalid domain");
    }

    $self->query({
        method => "GET",
        path => "/domains/".$domain,
    });
}


# Gets the records for a given domain
sub get_domain_records {
    my ($self, $domain) = @_;

    # TODO: Some better validation than it simply containing a dot
    unless ($domain =~ m/\.+/) {
        $self->throw("invalid domain");
    }

    $self->query({
        method => "GET",
        path => "/domains/".$domain."/records",
    });
}


# Gets an individal domain record
sub get_domain_record {
    my ($self, $domain, $id) = @_;

    # TODO: Some better validation than it simply containing a dot
    unless ($domain =~ m/\.+/) {
        $self->throw("invalid domain");
    }

    unless ($id =~ m/\d+/) {
        $self->throw("invalid record ID");
    }

    $self->query({
        method => "GET",
        path => "/domains/".$domain."/records/".$id,
    });
}


# Gets email forwarders
sub get_email_forwards {
    my ($self, $domain, $id) = @_;

    # TODO: Some better validation than it simply containing a dot
    unless ($domain =~ m/\.+/) {
        $self->throw("invalid domain");
    }

    $self->query({
        method => "GET",
        path => "/domains/".$domain."/email_forwards",
    });
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
