use strict;
use warnings;
use Test::More;


use Catalyst::Test 'BlueBox';
use BlueBox::Controller::Api::Ship;

ok( request('/api/ship')->is_success, 'Request should succeed' );
done_testing();
