use strict;
use warnings;
require "./Player.pm";

our $ransom = 1000;

package Jail;
sub new {
    my $class = shift;
    my $self  = {};
    bless $self, $class;
    return $self;
}

sub print {
    print("Jail ");
}

sub stepOn {
    my $self = shift;

    print("Pay \$1000 to reduce the prison round to 1? [y/n]\n");
    my $choice = <STDIN>;
    chomp($choice);
    if ($choice eq "y") {
        local $Player::due = 1000;               # dynamic scoping
        local $Player::handling_fee_rate = 0.1;  # dynamic scoping
        local $Player::prison_rounds = 1;        # dynamic scoping
        $main::cur_player->payDue();
        $main::cur_player->putToJail();
    } else {
        $main::cur_player->putToJail();
    }
}

1;