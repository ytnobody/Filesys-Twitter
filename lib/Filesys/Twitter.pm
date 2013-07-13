package Filesys::Twitter;
use 5.008005;
use strict;
use warnings;
use utf8;
use Fuse::Simple;
use Net::Twitter::Lite::WithAPIv1_1;

our $VERSION = "0.01";

binmode STDOUT, 'utf8';

sub new {
    my ($class, %opts) = @_;
    bless {twitter => Net::Twitter::Lite::WithAPIv1_1->new( %opts ) }, $class;
}

sub mount {
    my ($self, $mountpoint) = @_;
    $self->update_timeline;
    Fuse::Simple::main(
        mountpoint => $mountpoint, 
        "/"        => $self->{entry},
    );
}

sub update_timeline {
    my $self = shift;
    my $statuses = $self->{twitter}->home_timeline({ count => 100 });
    $self->{entry} = {};
    for my $status (@$statuses) {
        my $twitter_id = $status->{user}{screen_name};
        my $post_id    = $status->{id};
        my $entry_name = $twitter_id. '-'.$post_id;
        $self->{entry}{$entry_name} = $status->{text}."\n";
    }
}

1;
__END__

=encoding utf-8

=head1 NAME

Filesys::Twitter - Mount twitter stream as filesystem

=head1 SYNOPSIS

    use Filesys::Twitter;
    my $ft = Filesys::Twitter->new(
        consumer_key        => ...,
        consumer_secret     => ...,
        access_token        => ...,
        access_token_secert => ...,
    );
    $ft->mount('/tmp/twitter');

=head1 DESCRIPTION

Filesys::Twitter is FUSE based virtual filesystem that gives to access your twitter stream.

B<This software is ALPHA QUALITY and IN DEVELOPMENT.>

=head1 LICENSE

Copyright (C) ytnobody / satoshi azuma.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ytnobody / satoshi azuma E<lt>ytnobody@gmail.comE<gt>

=cut

