package BlueBox::Model::DB;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

use Path::Class qw(file);
use Catalyst::Utils;

my $db = file(Catalyst::Utils::home('BlueBox'),'bluebox.db');

__PACKAGE__->config(
    schema_class => 'BlueBox::DB',
    
    connect_info => {
        dsn => "dbi:SQLite:$db",
        user => '',
        password => '',
        sqlite_unicode => q{1},
        on_connect_call => q{use_foreign_keys},
        quote_names => q{1},
    }
);



1;
