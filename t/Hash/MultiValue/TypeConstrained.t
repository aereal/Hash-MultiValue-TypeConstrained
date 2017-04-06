use strict;
use warnings;

use Test::Deep qw(cmp_deeply);
use Test::More;

use Hash::MultiValue::TypeConstrained;

subtest '#get_typed' => sub {
  my $h = Hash::MultiValue::TypeConstrained->new(
    a => 1,
    b => 10,
    b => 20,
  );

  cmp_deeply $h->get_typed('Str', 'a'), '1';

  cmp_deeply $h->get_typed('Str', 'b'), 20;
  cmp_deeply $h->get_typed('ArrayRef[Str]', 'b'), [10, 20];

  local $@;
  eval {
      $h->get_typed('ArrayRef', 'a');
  };
  like $@, qr{\AType constraint must be concrete\b};
};

done_testing;
