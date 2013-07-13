# NAME

Filesys::Twitter - Mount twitter stream as filesystem

# SYNOPSIS

    use Filesys::Twitter;
    my $ft = Filesys::Twitter->new(
        consumer_key        => ...,
        consumer_secret     => ...,
        access_token        => ...,
        access_token_secert => ...,
    );
    $ft->mount('/tmp/twitter');

# DESCRIPTION

Filesys::Twitter is FUSE based virtual filesystem that gives to access your twitter stream.

__This software is ALPHA QUALITY and IN DEVELOPMENT.__

# LICENSE

Copyright (C) ytnobody / satoshi azuma.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

ytnobody / satoshi azuma <ytnobody@gmail.com>
