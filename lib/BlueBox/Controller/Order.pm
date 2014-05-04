package BlueBox::Controller::Order;
use Moose;
use namespace::autoclean;
use JSON qw(decode_json);

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

BlueBox::Controller::Order - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller for ordering new boxes.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    
    my $loc_id = $c->req->params->{location_id} || $self->get_new_location($c);

    $c->response->body('Matched BlueBox::Controller::Order in Order.');
}


sub get_location {
  my ( $self, $c ) = @_;
  
  my $Account = $c->model('DB::Account')->current_Account 
    or die "Not logged in."
  
  my $Location;
  my $Rs = $c->model('DB::Location');
  my $loc_id = $c->req->params->{location_id};
  if($loc_id) {
    $Location = $Rs->search_rs({ 'me.id' => $loc_id })->first
      or die "Location ID '$loc_id' not found";
  }
  else {
    my $loc_json = $c->req->params->{loc_json} or die "No location info supplied";
    my $loc = decode_json($loc_json);
    $Location = $Rs->create($loc) or die "Error creating new location";
  }
  
  return $Location;
  
}


__PACKAGE__->meta->make_immutable;

1;
