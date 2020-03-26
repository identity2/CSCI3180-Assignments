use strict;
use warnings;
require "./Player.pm";

package Bank;
sub new {
    my $class = shift;
    my $self  = {};
    bless $self, $class;
    return $self;
}

sub print {
    print("Bank ");
}

sub stepOn {

    # ...

    $main::cur_player->payDue();
    print("You received \$2000 from the Bank!\n");
}

1;