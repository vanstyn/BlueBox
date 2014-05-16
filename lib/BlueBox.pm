package BlueBox;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

use RapidApp 0.99203;
use RapidApp::Include qw(sugar perlutil);

use Catalyst qw/
    RapidApp::RapidDbic
    RapidApp::AuthCore
    RapidApp::NavCore
    RapidApp::CoreSchemaAdmin
/;

extends 'Catalyst';

our $VERSION = '0.01';
our $TITLE = "BlueBox v" . $VERSION;

my $tpl_regex = '^site\/';

__PACKAGE__->config(
    name => 'BlueBox',
    
    'Plugin::RapidApp::TabGui' => {
      title => $TITLE,
      nav_title => 'Administration',
      nav_title_iconcls => 'icon-bb-logo',
      navtree_init_width => 210,
      navtree_load_collapsed => 1,
      banner_template => 'banner.html',
      dashboard_url => '/tple/site/dashboard.md',
      template_navtree_regex => $tpl_regex
    },

    'Model::RapidApp' => {
      root_template_prefix  => 'site/public/page/',
      root_template         => 'site/public/page/home',
      disable_tabgui        => 1
    },
    
    'Controller::RapidApp::Template' => {
      default_template_extension => 'html',
      access_params => {
        writable_regex      => $tpl_regex,
        creatable_regex     => $tpl_regex,
        deletable_regex     => $tpl_regex,
        external_tpl_regex  => $tpl_regex.'public\/',
      },
      access_class => 'BlueBox::Template::Access',
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

# Special override for the 'admin' user only: turn back on the tabgui:
before 'finalize_body' => sub {
  my $c = shift;
  if($c->can('session') && $c->session) {
    $c->session->{disable_tabgui} = 0 if $c->check_any_user_role('administrator');
  }
};


1;
