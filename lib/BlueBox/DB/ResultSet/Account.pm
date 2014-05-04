package BlueBox::DB::ResultSet::Account;
use base 'DBIx::Class::ResultSet';

use RapidApp::Include qw(sugar perlutil);

use strict;
use warnings;

sub current_Account {
  my $self = shift;
  my $c = RapidApp->active_request_context or return undef;
  my $username = try{$c->user->username} or return undef;
  
  return $self->search_rs({ username => $username })->first;
}

1;
