BEGIN {
  use Path::Class qw/file dir/;
  $Bin = file($0)->parent->stringify; # Like FindBin
  $lib = "$Bin/lib";
}

use lib $lib;

use Plack::Util;
Plack::Util::load_psgi("$Bin/bluebox.psgi")
