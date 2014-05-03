use strict;
use warnings;

use BlueBox;

my $app = BlueBox->apply_default_middlewares(BlueBox->psgi_app);
$app;

