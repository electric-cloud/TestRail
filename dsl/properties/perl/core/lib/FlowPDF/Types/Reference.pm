package FlowPDF::Types::Reference;
use strict;
use warnings;
use Carp;

sub new {
    my ($class, @references) = @_;

    unless (@references) {
        croak "References are mandatory for this type definition";
    }
    my $self = {
        references => \@references
    };
    bless $self, $class;
    return $self;
}


sub match {
    my ($self, $value) = @_;

    return 0 if !ref $value;
    for my $ref (@{$self->{references}}) {
        if (ref $value eq $ref) {
            return 1;
        }
    }
    return 0;
}

sub describe {
    my ($self) = @_;

    my $refs = $self->{references};

    my $strRefs = join ', ', @$refs;
    my $str = "a reference to one of: $strRefs";
    return $str;
}

1;
