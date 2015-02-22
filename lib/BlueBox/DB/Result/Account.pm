use utf8;
package BlueBox::DB::Result::Account;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("account");
__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "username",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 64,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->has_many(
  "boxes",
  "BlueBox::DB::Result::Box",
  { "foreign.account_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "locations",
  "BlueBox::DB::Result::Location",
  { "foreign.account_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "orders",
  "BlueBox::DB::Result::Order",
  { "foreign.account_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2014-05-03 20:17:09
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:c/CClZLMRcuYr016uLlxmQ

use JSON qw(encode_json);
use RapidApp::Util qw(:all);

sub locations_list {
  my $self = shift;
  return [ map { { $_->get_columns } } $self->locations->all ];
}

sub boxes_list {
  my $self = shift;
  return [ map { $_->box_data } $self->boxes->all ];
}

sub boxes_list_json {
  my $self = shift;
  return try{ encode_json( $self->boxes_list ) } || '[]';
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
