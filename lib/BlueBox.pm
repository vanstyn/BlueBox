package BlueBox;
use Moose;
use namespace::autoclean;

use RapidApp 1.0401_09;

# ----
# RapidApp is enabled for the Catalyst application by loading one or
# more of its plugins in the standard manner, as provided by Catalyst,
# and shown below. 
#
# Not all of the plugins listed here are required because they are 
# implied by other plugins. For instance, the plugin 'RapidApp' (which 
# is actually Catalyst::Plugin::RapidApp) is automatically loaded with 
# any RapidApp plugin, so it would only need to be loaded if no other 
# RapidApp plugins were (and, by itself, it would be up to the user to 
# load and configure their own Modules from scratch)
#
# Some plugins also imply other plugins as well. For instance, the 
# RapidApp::CoreSchemaAdmin plugin implies the RapidApp::RapidDbic plugin,
# because that is what is used to present the "Admin" interfaces for
# managing user accounts and roles, which is that plugins job.
#
# And, RapidApp::RapidDbic also implies RapidApp::TabGui, because it uses
# that layout to present a nav tree of table/sources which can be clicked
# to load in the tab panel.
#
# So, the first three plugins below, RapidApp, RapidApp::RapidDbic and
# RapidApp::TabGui are actually redundant, but are being shown for the sake of
# better clarity, as these *are* the plugins which are loaded (even if not 
# shown as they are for this example app)
use Catalyst qw/
    RapidApp
    RapidApp::TabGui
    RapidApp::RapidDbic

    RapidApp::AuthCore
    RapidApp::NavCore
    RapidApp::CoreSchemaAdmin
/;
# ----

extends 'Catalyst';

our $VERSION = '0.02';
our $TITLE = "BlueBox v" . $VERSION;

my $tpl_regex = '^site\/';

__PACKAGE__->config(
    name => 'BlueBox',
    
    'RapidApp' => {
      # ---
      # This setting causes RapidApp to "take over" at '/adm/' instead of the
      # default which it at the root '/'. Use this setting when you need to 
      # integrate other, non-RapidApp controllers to function in the normal
      # Catalyst manner, including a custom root controller. RapidApp is still
      # fully available, just lives within/under the designated sub-namespace
      module_root_namespace => 'adm'
      # ---
    },
    
    # These config options apply to specific plugins which offer APIs to control
    # aspects of their behavior, but all configs are always optional, with sane
    # default states
    
    'Plugin::RapidApp::AuthCore' => {
      login_logo_url => '/assets/local/misc/static/imgs/bluebox-login-logo.png'
    },
    
    'Plugin::RapidApp::TabGui' => {
      title => $TITLE,
      nav_title => 'Administration',
      nav_title_iconcls => 'icon-bb-logo',
      navtree_init_width => 210,
      banner_template => 'banner.html',
      dashboard_url => '/tple/site/dashboard.md',
      template_navtree_regex => $tpl_regex,
      main_module_params => {
        require_role => 'administrator'
      }
    },
    
    # The Template Controller functionality is a part of RapidApp core. This
    # config allows setting up rules for what content is available, to who,
    # and using what template files. For this app, we have a public-facing set
    # of pages which can be edited via CMS features from within the TabGui
    # for authenticated users. All this is achieved in just this HashRef block 
    # of options
    'Controller::RapidApp::Template' => {
      root_template_prefix  => 'site/public/page/',
      root_template         => 'site/public/page/home',
      read_alias_path => '/tpl',  #<-- already the default
      edit_alias_path => '/tple', #<-- already the default
      default_template_extension => 'html',
      access_params => {
        writable_regex      => $tpl_regex,
        creatable_regex     => $tpl_regex,
        deletable_regex     => $tpl_regex,
        external_tpl_regex  => $tpl_regex.'public\/',
      },
      access_class => 'BlueBox::Template::Access',
    }
    
    
    # RapidDbic could be configured here, in the main app class, within a key like:
    #   'Plugin::RapidApp::RapidDbic' => { ... }
    #
    # However, for this app, the RapidDbic config is set within the config of the
    # DBIC model (BlueBox::Model::DB) which is an alternate config option, and is
    # purely up to the preference of the user. Keeping these configs in the model
    # class tends to make for a better organized app, which is why this is the default
    # config and suggested approach (but the main class config is still totally valid
    # and supported).

);

# Start the application
__PACKAGE__->setup();

1;
