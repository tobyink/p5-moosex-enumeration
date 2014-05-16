use 5.008001;
use strict;
use warnings;

package MooseX::Enumeration::Meta::Method::Accessor::Native::Enumeration::is;
our $AUTHORITY = 'cpan:TOBYINK';
our $VERSION   = '0.002';

use Moose::Role;
with 'Moose::Meta::Method::Accessor::Native::Reader';

sub _minimum_arguments { 1 }
sub _maximum_arguments { 1 }

sub _return_value {
	my $self = shift;
	my ($slot_access) = @_;
	return $slot_access . ' eq $_[0]';
}

1;
