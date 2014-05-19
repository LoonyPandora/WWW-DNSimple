package WWW::DNSimple::Role;

# ABSTRACT: Base role for the WWW::DNSimple module.

=head1 NAME

WWW::DNSimple::Role - Base role for the WWW::DNSimple module

=head1 SYNOPSIS

=cut

use strict;

use Moo::Role;
use LWP::UserAgent;
use JSON::XS;
use HTTP::Request;
use URI;
use Data::Dump qw(dump);

use WWW::DNSimple::Error;

with "Throwable";

has api_email => (is => 'rw', required => 1);
has api_token => (is => 'rw', required => 1);
has api_base  => (is => 'ro', required => 1, default => "https://api.sandbox.dnsimple.com"); # https://api.dnsimple.com/v1


# Returns a hashref of all required args to create a new object
sub required_args {
    my $self = shift;
    my $ret;
    foreach my $col ("api_email", "api_token", "api_base") {
        my $v = $self->$col;
        $ret->{$col} = $v if defined $v;
    }
    return $ret;
}


# Sends a request to the API
sub query {
    my ($self, $args) = @_;

    my $ua = LWP::UserAgent->new(
        env_proxy   => 1,
        timeout     => 60,
        agent       => __PACKAGE__ . "/0.0.1",
        requests_redirectable => [],
    );

    $ua->default_headers(HTTP::Headers->new(
        "Accept"            => "application/json",
        "X-DNSimple-Token"  => $self->api_email . ":" . $self->api_token,
    ));

    my $response = $ua->request(HTTP::Request->new(
        $args->{method}, $self->api_base . $args->{path}
    ));

    # TODO: Fix error handling
    if ($response->is_success) {
        return decode_json $response->content;
    }

    $self->throw({
        message => "Something went wrong - " . $response->status_line
    });
}


# Raises an exception
sub throw {
    my $self = shift;
    return WWW::DNSimple::Error->throw(@_);
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
