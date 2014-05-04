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

    'Model::RapidApp' => {
      root_template_prefix  => 'site/public/page/',
      root_template         => 'site/public/page/home',
      disable_tabgui        => 1
    },
    
    'Controller::RapidApp::Template' => {
      default_template_extension => 'html',
      access_params => {
        #writable_regex      => $tpl_regex,
        #creatable_regex     => $tpl_regex,
        #deletable_regex     => $tpl_regex,
        external_tpl_regex  => '^site\/',
      }
    },

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
