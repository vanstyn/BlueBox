use strict;
use warnings;
use Test::More;


use Catalyst::Test 'BlueBox';
use BlueBox::Controller::Order;

ok( request('/order')->is_success, 'Request should succeed' );
done_testing();
