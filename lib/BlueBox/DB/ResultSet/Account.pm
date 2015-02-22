package BlueBox::DB::ResultSet::Account;
use base 'DBIx::Class::ResultSet';

use RapidApp::Util qw(:all);

use strict;
use warnings;

sub current_Account {
  my $self = shift;
  my $c = RapidApp->active_request_context or return undef;
  
  my $username = try{$c->user->username} or return undef;
  
  my $Account = $self->search_rs({ username => $username })->first;
  return $Account if ($Account);
  
  # Auto-create account if the user exists:
  return $self->create({ username => $username });
}

1;
