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