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
    while ($choice ne "y" && $choice ne "n") {
        print("Pay \$1000 to reduce the prison round to 1? [y/n]\n");
        $choice = <STDIN>;
        chomp($choice);
    }
    
    if ($choice eq "y") {
        if ($main::cur_player->{money} < 1100) {
            print("You do not have enough money to reduce the prison round!\n");
            $main::cur_player->putToJail();
        } else {
            local $Player::due = 1000;               # dynamic scoping
            local $Player::handling_fee_rate = 0.1;  # dynamic scoping
            local $Player::prison_rounds = 1;        # dynamic scoping
            $main::cur_player->payDue();
            $main::cur_player->putToJail();
        }        
    } else {
        $main::cur_player->putToJail();
    }
}

1;