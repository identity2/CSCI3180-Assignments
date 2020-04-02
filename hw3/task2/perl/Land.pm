# CSCI3180 Principles of Programming Languages
#
# --- Declaration ---
#
# I declare that the assignment here submitted is original except for source
# material explicitly acknowledged. I also acknowledge that I am aware of
# University policy and regulations on honesty in academic work, and of the
# disciplinary guidelines and procedures applicable to breaches of such policy
# and regulations, as contained in the website
# http://www.cuhk.edu.hk/policy/academichonesty/
#
# Assignment 3
# Name : Chao Yu
# Student ID : 1155053722
# Email Addr : ychao5@cse.cuhk.edu.hk

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
    my $self = shift;
    local $Player::due = 1000;   # dynamic scoping
    local $Player::handling_fee_rate = 0.1; # dynamic scoping
    $main::cur_player->payDue();

    $self->{owner} = $main::cur_player;
}

sub upgradeLand {
    my $self = shift;
    my $cost = shift;

    local $Player::handling_fee_rate = 0.1; # dynamic scoping.
    local $Player::due = $cost; # dynamic scoping
    $main::cur_player->payDue();

    $self->{level} = $self->{level} + 1;
}

sub chargeToll {
    my $self = shift;
    my $cost = shift;
    my $tax = shift;

    if ($main::cur_player->{money} < $cost) {
        $cost = $main::cur_player->{money}
    }

    local $Player::due = $cost;   # dynamic scoping
    $main::cur_player->payDue();

    $Player::due = 0;
    local $Player::income = $cost;  # dynamic scoping
    local $Player::tax_rate = $tax; # dynamic scoping
    $self->{owner}->payDue();
}

sub stepOn {
    my $self = shift;
    
    if (!defined($self->{owner})) {
        # Unowned.
        print("Pay \$1000 to buy the land? [y/n]\n");
        my $choice = <STDIN>;
        chomp($choice);
        while ($choice ne "y" && $choice ne "n") {
            print("Pay \$1000 to buy the land? [y/n]\n");
            $choice = <STDIN>;
            chomp($choice);
        }
        
        if ($choice eq "y") {
            if ($main::cur_player->{money} < 1100) {
                print("You do not have enough money to buy the land!\n");
            } else {
                $self->buyLand();
            }
        }
    } elsif ($self->{owner} == $main::cur_player) {
        # Owned by the player.
        my $cost;
        if ($self->{level} == 0) {
            $cost = 1000;
        } elsif ($self->{level} == 1) {
            $cost = 2000;
        } elsif ($self->{level} == 2) {
            $cost = 5000;
        } else {
            # Already highest level.
            return;
        }
        print("Pay \$".$cost." to upgrade the land? [y/n]\n");
        
        my $choice = <STDIN>;
        chomp($choice);
        while ($choice ne "y" && $choice ne "n") {
            print("Pay \$".$cost." to upgrade the land? [y/n]\n");
            $choice = <STDIN>;
            chomp($choice);
        }
        
        if ($choice eq "y") {
            if ($main::cur_player->{money} < $cost * 1.1) {
                print("You do not have enough money to upgrade the land!\n");
            } else {
                $self->upgradeLand($cost);
            }
        }
    } else {
        # Owned by the opponent.
        my $cost;
        my $tax;
        if ($self->{level} == 0) {
            $cost = 500;
            $tax = 0.1;
        } elsif ($self->{level} == 1) {
            $cost = 1000;
            $tax = 0.15;
        } elsif ($self->{level} == 2) {
            $cost = 1500;
            $tax = 0.2;
        } elsif ($self->{level} == 3) {
            $cost = 3000;
            $tax = 0.25;
        }
        print("You need to pay player ".$self->{owner}->{name}." \$".$cost."\n");
        $self->chargeToll($cost, $tax);
    }

}
1;