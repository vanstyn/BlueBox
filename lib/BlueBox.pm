package BlueBox;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

use RapidApp 0.99202;

use Catalyst qw/
    RapidApp::RapidDbic
    RapidApp::AuthCore
    RapidApp::NavCore
    RapidApp::CoreSchemaAdmin
/;

extends 'Catalyst';

our $VERSION = '0.01';
our $TITLE = "BlueBox v" . $VERSION;

__PACKAGE__->config(
    name => 'BlueBox',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,

    'Plugin::RapidApp::RapidDbic' => {
      dbic_models => ['DB'],
      hide_fk_columns => 1,
      configs => {
        DB => {
          grid_params => {
            '*defaults' => {
              updatable_colspec => ['*'],
              creatable_colspec => ['*'],
              destroyable_relspec => ['*'],
            }
          },
          TableSpecs => {
            Account => {
              
            },
            BoxType => {
              
            },
            BoxStatus => {
              
            },
            Box => {
              
            },
            Item => {
              
            },
            Location => {
              
            },
            Shipment => {
              
            },
            Warehouse => {
              
            
            }
            
          }
        },
      }
    },
);

# Start the application
__PACKAGE__->setup();



1;
