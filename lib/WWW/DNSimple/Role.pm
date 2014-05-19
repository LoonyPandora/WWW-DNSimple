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

with "Throwable";

has ua => (is => 'ro', lazy => 1, default => \&_ua);
has api_token => (is => 'ro', required => 1);
has api_base => (is => 'ro', required => 1, default => \&_api_base );
has sandbox => (is => 'ro', default => sub { 0 });




# Returns a hashref of all required args to create a new object
sub required_args {
    my $self = shift;
    my $ret;
    foreach my $col ("api_token", "api_base") {
        my $v = $self->$col;
        $ret->{$col} = $v if defined $v;
    }
    return $ret;
}



# Provides the LWP::UserAgent object everywhere.
sub _ua {
    return LWP::UserAgent->new(
        env_proxy   => 1,
        timeout     => 60,
        agent       => __PACKAGE__ . "/0.0.1",
        requests_redirectable => [],
    );
}



# Gets an API endpoint, can be mocked
sub _api_base {
    my $self = shift;
    # FIXME: Doesn't work. Figure out exceptions
    if ($self->sandbox) {
        __PACKAGE__->throw("Sandbox is unimplemented");
    } else {
        return "https://api.dnsimple.com/v1";
    }
}


# Sends a request to the API
sub query {
    my ($self, $args) = @_;

    my $request = HTTP::Request->new($args->{method}, $self->api_base . $args->{path});

    my $response = $self->ua->request($request);
    
    if ($response->is_success) {
        return decode_json $response->content;
    }
    
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
