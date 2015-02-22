package BlueBox::Template::Access;
use strict;
use warnings;

use RapidApp::Util qw(:all);

use Moo;

extends 'RapidApp::Template::Access';

around 'get_template_vars' => sub {
  my ($orig,$self,@args) = @_;
  
  my $vars = $self->$orig(@args);
  
  my $c = RapidApp->active_request_context or return $vars;
  $vars->{account} = $c->model('DB::Account')->current_Account;
  
  return $vars;
};

1;