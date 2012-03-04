use Test::More tests => 5;

BEGIN { use_ok WWW::Shorten::Yahooit };

my $url = 'http://search.cpan.org/~cwimmer/';
my $return = makeashorterlink($url);
is ( makeashorterlink($url), $return, 'make it shorter');
is ( makealongerlink($return), $url, 'make it longer');

eval { &makeashorterlink() };
ok($@, 'makeashorterlink fails with no args');
eval { &makealongerlink() };
ok($@, 'makealongerlink fails with no args');
