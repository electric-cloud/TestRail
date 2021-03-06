package FlowPDF::StepResult::Action;
use base qw/FlowPDF::BaseClass2/;
use FlowPDF::Types;

__PACKAGE__->defineClass({
    actionType  => FlowPDF::Types::Scalar(),
    entityName  => FlowPDF::Types::Scalar(),
    entityValue => FlowPDF::Types::Scalar(),
});

use strict;
use warnings;
use Carp;

my $supportedActions = {
    setOutputParameter => 1,
    setPipelineSummary => 1,
    setJobStepOutcome  => 1,
    setJobOutcome      => 1,
    setOutcomeProperty => 1,
    setJobSummary      => 1,
    setJobStepSummary  => 1,
    setReportUrl       => 1,
};


sub classDefinition {
    return {
        actionType => 'str',
        entityName => 'str',
        entityValue => 'str'
    };
}


sub new {
    my ($class, $params) = @_;

    if (!$supportedActions->{$params->{actionType}}) {
        croak "Action Type $params->{actionType} is not supported. Supported actions are: ", join(', ', keys %$supportedActions);
    }

    return $class->SUPER::new($params);
}

1;
