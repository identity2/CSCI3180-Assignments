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

package Player;
use Deck;

# Instantiates a new Player object with its name.
# Params: pkg name, player name.
sub new {
    my $class = shift @_;
    my @cards = ();
    my $self = {
        "name" => shift @_,
        "cards" => \@cards,
    };
    my $object = bless $self, $class;
    return $object;
}

# Put the taken cards to the bottom of the deck.
# Params: obj ref, cards
sub getCards {
    my $self = shift @_;
    my $cards = shift @_;

    for my $card (@$cards) {
        push @{$self->{"cards"}}, $card;
    }
    return 1;
}

# Take a card from the top of the deck and deal it to the game.
# Params: obj ref
sub dealCards {
    my $self = shift @_;
    my $card = shift @{$self->{"cards"}};
    return $card;
}

# Return the number of player's cards.
# Params: obj ref
sub numCards {
    my $self = shift @_;
    my $num = @{$self->{"cards"}};
    return $num;
}

return 1;