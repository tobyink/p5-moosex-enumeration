use 5.008001;
use strict;
use warnings;

package Moose::Meta::Attribute::Custom::Trait::Enum;
our $AUTHORITY = 'cpan:TOBYINK';
our $VERSION   = '0.010';

sub register_implementation {
	'MooseX::Enumeration::Meta::Attribute::Native::Trait::Enumeration';
}

1;
