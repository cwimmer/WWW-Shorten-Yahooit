use strict;
use warnings;
package WWW::Shorten::Yahooit;
use base qw( WWW::Shorten::generic Exporter );
our @EXPORT = qw( makeashorterlink makealongerlink );
use WWW::YQL;
use Carp;

# ABSTRACT: Perl interface to y.ahoo.it
# PODNAME: WWW::Shorten::Yahooit

=head1 SYNOPSIS

use WWW::Shorten::Yahooit;
use WWW::Shorten 'Yahooit';

$short_url = makeashorterlink($long_url);

$long_url  = makealongerlink($short_url);

=head2 DESCRIPTION

This module uses YQL to create shortened URLs using the y.ahoo.it URL
shortening service from Yahoo!

=cut

=method makeashorterlink

The function makeashorterlink will do an insert on the yahoo.y.ahoo.it
table on the Yahoo! YQL service passing it your long URL and will
return the shorter version.

=cut

sub makeashorterlink{
    my $url = shift or croak 'No URL passed to makeashorterlink';
    my $yql = WWW::YQL->new();

    my $data = $yql->query("insert into yahoo.y.ahoo.it (url) values ('".$url."')");
    if (defined $data->{'query'}->{'results'}->{'error'}){
	die $data->{'query'}->{'results'}->{'error'};
    }else{
	return $data->{'query'}->{'results'}->{'url'};
    }
}

=method makealongerlink

The function makealongerlink will do an select on the yahoo.y.ahoo.it
table on the Yahoo! YQL service passing it your short URL and will
return the longer version.

=cut
sub makealongerlink{
    my $url = shift or croak 'No URL passed to makeashorterlink';
    my $yql = WWW::YQL->new();
    my $data = $yql->query("select * from yahoo.y.ahoo.it where url='".$url."'");
    if (defined $data->{'query'}->{'results'}->{'error'}){
	die $data->{'query'}->{'results'}->{'error'};
    }else{
	return $data->{'query'}->{'results'}->{'url'};
    }
}
1;
