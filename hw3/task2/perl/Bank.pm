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

package Bank;

our $money = 2000;

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
    my $self = shift;

    local $Player::tax_rate = 0;   # dynamic scoping
    local $Player::income = 2000;  # dynamic scoping
    local $Player::due = 0;        # dynamic scoping
    $main::cur_player->payDue();
    print("You received \$2000 from the Bank!\n");
}

1;