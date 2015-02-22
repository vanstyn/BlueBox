package BlueBox::Controller::Api::Ship;
use Moose;
use namespace::autoclean;

use strict;
use warnings;

use JSON qw(decode_json);

use RapidApp::Util qw(:all);

BEGIN { extends 'Catalyst::Controller'; }

sub now_dt { DateTime->now( time_zone => 'local' ) }

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    
    my $Account = $c->model('DB::Account')->current_Account or die "Not logged in.";
    my $params = $c->req->params;
    
    my $box_json = $c->req->params->{box_json} or die "No box info supplied";
    my $box = decode_json($box_json);
    
    my %create = (
      account_id  => $Account->get_column('id'),
      name => $box->{boxName}
    );
    
    my $Exist = $c->model('DB::Box')->search_rs(\%create)->first;
    $create{name} = $create{name} . '-' . $Exist->get_column('id') if ($Exist);
    $create{type_id} = 1;
    $create{status_id} = 1;

    my $Box = $c->model('DB::Box')->create(\%create)->get_from_storage or die "Error creating box";

    my $ItmRs = $c->model('DB::Item');
    $ItmRs->create({
      box_id => $Box->get_column('id'),
      name => $_
    }) for ( @{ $box->{boxItems} || [] });
    
    # TODO: dispatch to a real view
    $c->res->content_type('application/json; charset=utf-8');
    $c->res->header('Cache-Control' => 'no-cache');
    $c->res->status(200);
    $c->res->body(encode_json_utf8({ $Box->get_columns }));
    return $c->detach;
}


__PACKAGE__->meta->make_immutable;

1;
