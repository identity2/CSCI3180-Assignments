use strict;
use warnings;
package Land;

sub new {
    my $class = shift;
    my $self  = {
        owner => undef,
        level => 0,
    };
    bless $self, $class;
    return $self;
}

sub print {
    my $self = shift;
    if (!defined($self->{owner})) {
        print("Land ");
    } else {
        print("$self->{owner}->{name}:Lv$self->{level}");
    }
}

sub buyLand {

    # ...

    $main::cur_player->payDue();
}

sub upgradeLand {

    # ... 

    $main::cur_player->payDue();
}

sub chargeToll {

    # ...

    $main::cur_player->payDue();

    # ...

    $self->{owner}->payDue();
}

sub stepOn {

    # ...

}
1;