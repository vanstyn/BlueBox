package BlueBox::Controller::Order;
use Moose;
use namespace::autoclean;

use RapidApp::Include qw(sugar perlutil);

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

BlueBox::Controller::Order - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller for ordering new boxes.

=head1 METHODS

=cut


=head2 index

=cut

sub now_dt { DateTime->now( time_zone => 'local' ) }
sub dtf { }

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    
    my $Account = $c->model('DB::Account')->current_Account or die "Not logged in.";
    my $Location = $self->get_location($c,$Account)
    
    my $params = $c->req->params;
    
    my $loc_id = $params->{location_id} || $self->get_new_location($c);
    my $qty = $params->{qty} or die "qty required";
    
    my $dtf = $c->model('DB')->schema->storage->datetime_parser;
    
    my $Order = $c->model('DB::Order')->create({
      account_id  => $Account->get_column('id'),
      location_id => $Location->get_column('id'),
      qty         => $qty,
      ordered_on  => $dtf->format_datetime( &now_dt )
    })->get_from_storage or die "Error creating order"
    
    # TODO: dispatch to a real view
    $c->res->content_type('application/json; charset=utf-8');
    $c->res->header('Cache-Control' => 'no-cache');
    $c->res->status(200);
    $c->res->body(encode_json_utf8({ $Order->get_columns }));
    return $c->detach;
}


sub get_location {
  my ( $self, $c, $Account ) = @_;
  
  $Account ||= $c->model('DB::Account')->current_Account or die "Not logged in.";
  my $acc_id = $Account->get_column('id');
  
  my $Location;
  my $Rs = $c->model('DB::Location');
  my $loc_id = $c->req->params->{location_id};
  if($loc_id) {
    $Location = $Rs->search_rs({ 
      'me.id'         => $loc_id,
      'me.account_id' => $acc_id
    })->first or die "Location ID '$loc_id' not found";
  }
  else {
    my $loc_json = $c->req->params->{loc_json} or die "No location info supplied";
    my $loc = decode_json_uft8($loc_json);
    $Location = $Rs->create({
      %$loc,
      account_id => $acc_id
    }) or die "Error creating new location";
  }
  
  return $Location;
}


__PACKAGE__->meta->make_immutable;

1;
