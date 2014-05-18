use v5.14;
use strictures;
no warnings qw(void);
use Benchmark qw(cmpthese);

package Local::Standard
{
	use Moose;
	has status => (
		traits   => ['Enumeration'],
		is       => 'ro',
		enum     => [qw( pass fail )],
		handles  => 1,
	);
}

package Local::WithXS
{
	use Moose;
	use MooseX::XSAccessor;
	has status => (
		traits   => ['Enumeration'],
		is       => 'ro',
		enum     => [qw( pass fail )],
		handles  => 1,
	);
}

for my $class (qw/ Local::Standard Local::WithXS /)
{
	say "Testing $class";
	my $obj = $class->new(status => 'fail');
	cmpthese -1, {
		delegation => sub {
			my $var;
			$var += $obj->is_pass || $obj->is_fail
				for 1..1000;
		},
		eq => sub {
			my $var;
			$var += $obj->status eq 'pass' || $obj->status eq 'fail'
				for 1..1000;
		},
	};
}
