use strict;
use warnings;
use base qw/FlowPDF/;
use Data::Dumper;



# Feel free to use new libraries here, e.g. use File::Temp;
use FlowPDF::Log;
use FlowPDF::ComponentManager;
use FlowPDF::Helpers qw/bailOut/;
use FlowPlugin::REST;

use JSON;
# use JSON qw/decode_json/;
# use JSON qw/encode_json/;

# Service function that is being used to set some metadata for a plugin.
sub pluginInfo {
    return {
        pluginName      => '@PLUGIN_KEY@',
        pluginVersion   => '@PLUGIN_VERSION@',
        configFields    => [ 'config' ],
        configLocations => [ 'ec_plugin_cfgs' ]
    };
}

# Auto-generated method for the procedure Get Test As JSON to TestRail/Get Test As JSON to TestRail
# Add your code into this method and it will be called when step runs
sub init {
    my ($self, $params) = @_;

    my FlowPDF::Context $context = $self->getContext();
    my $configValues = $context->getConfigValues($params->{config});

    # Will add
    $self->{_config} = $configValues;

    $self->{restClient} = FlowPlugin::REST->new($configValues, {
        APIBase     => '/api/v2/',
        contentType => 'application/json',
        errorHook   => {
            default => sub {
                return $self->defaultErrorHandler(@_)
            }
        }
    });
}

sub config {return shift->{_config}};

#@returns FlowPlugin::REST
sub client {return shift->{restClient}};

=head2 getTestAsJSONToTestRail

TODO: Documentation for this Procedure

=cut
# Auto-generated method for the procedure Get Test Case/Get Test Case
# Add your code into this method and it will be called when step runs
sub getTestCase {
    my ($pluginObject) = @_;

    my $context = $pluginObject->newContext();
    print "Current context is: ", $context->getRunContext(), "\n";
    # my $params = $context->getStepParameters();
    # print Dumper $params;
    my FlowPDF $self = shift;
    my $params = shift;
    print Dumper $params;
    my FlowPDF::StepResult $stepResult = shift;
    $self->init($params);

    # Setting default parameters
    $params->{resultFormat} ||= 'json';
    $params->{resultPropertySheet} ||= '/myJob/caseId/';

    my $caseId = "$params->{caseId}";

    my $response = $self->client->get("get_case/$caseId", undef, undef, {
        errorHook => {
            400 => sub {
                $stepResult->setJobStepOutcome('error');
                $stepResult->setJobSummary("Case '$caseId' was not found");
                $stepResult->setJobStepSummary("Case '$caseId' was not found");
                return;
            }
        }
    });

    return unless defined $response;
    logInfo("Found case: '$response->{id}'");

    # my $infoToSave = $response;

    # # Save to a properties
    # $self->saveResultProperties(
    #     $stepResult,
    #     $params->{resultFormat},
    #     $params->{resultPropertySheet},
    #     $infoToSave
    # );

    # Saving outcome properties and parameters
    $stepResult->setOutputParameter('caseId', $response->{id});
    $stepResult->setOutputParameter('response', encode_json $response);
    logInfo("Plan(s) information was saved to properties.");

    $stepResult->setJobStepOutcome('success');
    $stepResult->setJobStepSummary('Case found: ' . $response->{id});
    $stepResult->setJobSummary("Info about $caseId was saved to property(ies)");

    print "Created stepResult\n";
    $stepResult->setJobStepOutcome('success');
    print "Set stepResult\n";

    $stepResult->setJobSummary("Info about $caseId was saved to property(ies)");
    $stepResult->setJobStepSummary('Case found: ' . $response->{id});

    $stepResult->apply();
}
# Auto-generated method for the procedure Create Test Case/Create Test Case
# Add your code into this method and it will be called when step runs
sub createTestCase {
    my ($pluginObject) = @_;
    my $context = $pluginObject->newContext();
    print "Current context is: ", $context->getRunContext(), "\n";
    my $params = $context->getStepParameters();
    print Dumper $params;

    my $configValues = $context->getConfigValues();
    print Dumper $configValues;

    my $stepResult = $context->newStepResult();
    print "Created stepresult\n";
    $stepResult->setJobStepOutcome('warning');
    print "Set stepResult\n";

    $stepResult->setJobSummary("See, this is a whole job summary");
    $stepResult->setJobStepSummary('And this is a job step summary');

    $stepResult->apply();
}
# Auto-generated method for the procedure Update Test Case/Update Test Case
# Add your code into this method and it will be called when step runs
sub updateTestCase {
    my ($pluginObject) = @_;
    my $context = $pluginObject->newContext();
    print "Current context is: ", $context->getRunContext(), "\n";
    my $params = $context->getStepParameters();
    print Dumper $params;

    my $configValues = $context->getConfigValues();
    print Dumper $configValues;

    my $stepResult = $context->newStepResult();
    print "Created stepresult\n";
    $stepResult->setJobStepOutcome('warning');
    print "Set stepResult\n";

    $stepResult->setJobSummary("See, this is a whole job summary");
    $stepResult->setJobStepSummary('And this is a job step summary');

    $stepResult->apply();
}

sub defaultErrorHandler {
    my FlowPDF $self = shift;
    my ($response, $decoded) = @_;

    logDebug(Dumper \@_);

    if (!$decoded || !$decoded->{message}) {
        $decoded->{message} = 'No specific error message was returned. Check logs for details';
        logError($response->decoded_content || 'No content returned');
    }

    my FlowPDF::StepResult $stepResult = $self->getContext()->newStepResult();
    $stepResult->setJobStepOutcome('error');
    $stepResult->setJobStepSummary($decoded->{message});
    $stepResult->setJobSummary("Error happened while performing the operation: '$decoded->{message}'");
    $stepResult->apply();

    return;
}

## === step ends ===
# Please do not remove the marker above, it is used to place new procedures into this file.


1;