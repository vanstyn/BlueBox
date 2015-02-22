package BlueBox;
use Moose;
use namespace::autoclean;

use RapidApp 1.0010;

use Catalyst qw/
    RapidApp::AuthCore
    RapidApp::NavCore
    RapidApp::CoreSchemaAdmin
/;

extends 'Catalyst';

our $VERSION = '0.02';
our $TITLE = "BlueBox v" . $VERSION;

my $tpl_regex = '^site\/';

__PACKAGE__->config(
    name => 'BlueBox',
    
    'RapidApp' => {
      module_root_namespace => 'adm'
    },
    
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
      template_navtree_regex => $tpl_regex
    },
    
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
);

# Start the application
__PACKAGE__->setup();

1;
