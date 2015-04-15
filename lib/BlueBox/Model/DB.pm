package BlueBox::Model::DB;
use Moo;
extends 'Catalyst::Model::DBIC::Schema';

use strict;
use warnings;

use Path::Class qw(file);
use Catalyst::Utils;

my $db = file(Catalyst::Utils::home('BlueBox'),'bluebox.db');

# Auto-deploy:
before 'setup' => sub {
  my $self = shift;
  return if (-f $db);
  $self->schema_class->connect($self->connect_info->{dsn})->deploy;
};

__PACKAGE__->config(
    schema_class => 'BlueBox::DB',
    
    connect_info => {
        dsn => "dbi:SQLite:$db",
        user => '',
        password => '',
        sqlite_unicode => q{1},
        on_connect_call => q{use_foreign_keys},
        quote_names => q{1},
    },
    
    # The existence of the config key 'RapidDbic' automatically enables
    # this model/schema to be setup in the interface *if* the 
    # RapidApp::RapidDbic plugin has been loaded (in the main app class).
    # Otherwise, this is just passive extra data and will have no effect...
    RapidDbic => {
      hide_fk_columns => 1,
      grid_params => {
        '*defaults' => {
          updatable_colspec => ['*'],
          creatable_colspec => ['*'],
          destroyable_relspec => ['*'],
        }
      },
      TableSpecs => {
        Account => {
          display_column => 'username'
        },
        BoxType => {
          display_column => 'name'
        },
        BoxStatus => {
          display_column => 'name'
        },
        Box => {
          
        },
        Item => {
          
        },
        Location => {
          display_column => 'name'
        },
        Shipment => {
          
        },
        Warehouse => {
          
        }
      }
    }
);


1;
