=head1 NAME

FlowPDF::ComponentManager

=head1 AUTHOR

CloudBees

=head1 DESCRIPTION

FlowPDF::ComponentManager is a class that provides you an access to FlowPDF Components infrastructure.

This class allows you to load components depending on you needs.

Currently, there are 2 components loading strategies supported.

=over 4

=item B<Local>

Local component is being loaded to current FlowPDF::ComponentManager object context.

So, it is only possible to access it from current object.

=item B<Global>

This is default strategy, component is being loaded for whole execution context and could be accessed from any FlowPDF::ComponentManager object.

=back

=head1 METHODS

=cut

package FlowPDF::ComponentManager;
use strict;
use warnings;

use Data::Dumper;
use Carp;

use FlowPDF::Log;
use FlowPDF::Helpers qw/bailOut/;

our $COMPONENTS = {};

=head2 new()

=head3 Description

This method creates a new FlowPDF::ComponentManager object. It doesn't have parameters.

=head3 Parameters

=over 4

=item None

=back

=head3 Returns

=over 4

=item FlowPDF::ComponentManager

=back

=head3 Usage

%%%LANG=perl%%%

    my $componentManager = FlowPDF::ComponentManager->new();

%%%LANG%%%

=cut

sub new {
    my ($class, $pluginObject) = @_;

    if (!$pluginObject) {
        logWarning("pluginObject parameter is required for FlowPDF::ComponentManager initialization, consider to add it.");
    }
    my $self = {
        components_local => {},
    };

    if ($pluginObject) {
        $self->{pluginObject} = $pluginObject;
    }
    bless $self, $class;
    return $self;
}

=head2 loadComponentLocal($componentName, $initParams)

=head3 Description

Loads, initializes the component and returns its as FlowPDF::Component:: object in context of current FlowPDF::ComponentManager object.

=head3 Parameters

=over 4

=item (Required)(String) A name of the component to be loaded

=item (Required)(HASH ref) An init parameters for the component.

=back

=head3 Returns

=over 4

=item FlowPDF::Component:: object

=back

=head3 Usage

%%%LANG=perl%%%

    $componentManager->loadComponentLocal('FlowPDF::Component::YourComponent', {one => two});

%%%LANG%%%

Accepts as parameters component name and initialization values. For details about initialization values see L<FlowPDF::Component>

=cut

sub loadComponentLocal {
    my ($self, $component, $params, $pluginObject) = @_;

    eval "require $component";
    $component->import();

    my $o;
    if ($component->isEFComponent()) {
        if (!$pluginObject) {
            bailOut("Plugin Object is required if FlowPDF::Component::EF::* or its subclass is being loaded");
        }
        $o = $component->init($pluginObject, $params);
    }
    else {
        $o = $component->init($params);
    }
    $self->{components_local}->{$component} = $o;
    return $o;
}

=head2 loadComponent($componentName, $initParams)

=head3 Description

Loads, initializes the component and returns its as FlowPDF::Component:: object in global context.

=head3 Parameters

=over 4

=item (Required)(String) A name of the component to be loaded

=item (Required)(HASH ref) An init parameters for the component.

=back

=head3 Returns

=over 4

=item FlowPDF::Component:: object

=back

=head3 Usage

%%%LANG=perl%%%

    $componentManager->loadComponentLocal('FlowPDF::Component::YourComponent', {one => two});

%%%LANG%%%

Accepts as parameters component name and initialization values. For details about initialization values see L<FlowPDF::Component>

=cut

sub loadComponent {
    my ($self, $component, $params, $pluginObject) = @_;

    logTrace("Loading component $component using params" . Dumper $params);
    eval "require $component" or do {
        croak "Can't load component $component: $@";
    };
    logTrace("Importing component $component...");
    $component->import();
    logTrace("Imported Ok");

    logTrace("Initializing $component...");
    my $o;
    if ($component->isEFComponent()) {
        if (!$pluginObject) {
            bailOut("Plugin Object is required if FlowPDF::Component::EF::* or its subclass is being loaded.");
        }
        $o = $component->init($pluginObject, $params);
    }
    else {
        $o = $component->init($params);
    }

    logTrace("Initialized Ok");
    $COMPONENTS->{$component} = $o;
    return $o;
}


=head2 getComponent($componentName)

=head3 Description

Returns an FlowPDF::Component object that was previously loaded globally. For local context see getComponentLocal.

=head3 Parameters

=over 4

=item (Required)(String) Component to get from global context.

=back

=head3 Returns

=over 4

=item FlowPDF::Component:: object

=back

=head3 Usage

%%%LANG=perl%%%

    my $component = $componentManager->getComponent('FlowPDF::Component::Proxy');

%%%LANG%%%

=cut

sub getComponent {
    my ($self, $component) = @_;

    if (!$COMPONENTS->{$component}) {
        croak "Component $component has not been loaded as local component. Please, load it before you can use it.";
    }
    return $COMPONENTS->{$component};
}

=head2 getComponentLocal($componentName)

=head3 Description

Returns an FlowPDF::Component object that was previously loaded in local context.

=head3 Parameters

=over 4

=item (Required)(String) Component to get from local context.

=back

=head3 Returns

=over 4

=item FlowPDF::Component:: object

=back

=head3 Usage

%%%LANG=perl%%%

    my $component = $componentManager->getComponent('FlowPDF::Component::Proxy');

%%%LANG%%%

=cut

sub getComponentLocal {
    my ($self, $component) = @_;

    if (!$self->{components_local}->{$component}) {
        croak "Component $component has not been loaded. Please, load it before you can use it.";
    }
    return $self->{components_local}->{$component};
}

1;
