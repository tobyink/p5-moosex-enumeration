use 5.008001;
use strict;
use warnings;

package MooseX::Enumeration::Meta::Method::Accessor::Native::Enumeration::is;
our $AUTHORITY = 'cpan:TOBYINK';
our $VERSION   = '0.003';

use Moose::Role;
with 'Moose::Meta::Method::Accessor::Native::Reader';

sub _minimum_arguments { 1 }
sub _maximum_arguments { 1 }

sub _return_value
{
	my $self = shift;
	my ($slot_access) = @_;
	return $slot_access . ' eq $_[0]';
}

around _generate_method => sub
{
	my $next = shift;
	my $self = shift;
	
	my @curried = @{ $self->curried_arguments };
	
	if (@curried==1 and defined $curried[0] and not ref $curried[0])
	{
		require B;
		require Moose::Util;
		return sprintf(
			'sub { @_ > 1 and %s; %s eq %s }',
			"Moose::Util::throw_exception('MethodExpectsFewerArgs', 'method_name', 'is', 'maximum_args', 1)",
			$self->_get_value('$_[0]'),
			B::perlstring($curried[0]),
		);
	}
	
	$self->$next(@_);
};

1;
