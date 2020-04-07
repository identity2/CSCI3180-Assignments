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

package Game;
use MannerDeckStudent;
use Player;
use Deck;

# Instantiate the Game object.
# Params: pkg name, deck, players, cards
sub new {
	my $class = shift @_;
    my @players = ();
    my @cards = ();
    my $self = {
        "deck" => MannerDeckStudent->new(),
        "players" => \@players,
        "cards" => \@cards,
    };
    my $object = bless $self, $class;
    return $object;
}

# Initialize the player list by their names.
# Params: obj ref, player names
sub setPlayers {
    my $self = shift @_;
    my $players_name = shift @_;

    # Check if the player numbers divide 52.
    if (@$players_name == 0 || 52 % @$players_name != 0) {
        print "Error: cards' number 52 can not be divided by players number ";
        print @$players_name."!\n";
        return 0;
    }

    for my $name (@$players_name) {
        push @{$self->{"players"}}, Player->new($name);
    }

    return 1;
}

# Calculate how many will be returned to the player from the desktop.
# Params: obj ref.
sub getReturn {
    my $self = shift @_;
    my $last = $self->{"cards"}->[-1];
    my $numCards = @{$self->{"cards"}};
    my @ret = ();
    
    if ($last eq "J" && $numCards != 1) {
        # Return all cards.
        while (@{$self->{"cards"}} > 0) {
            my $card = pop @{$self->{"cards"}};
            push @ret, $card;
        }
    } else {
        for my $i (0..$numCards-2) {
            # There is a match.
            if ($self->{"cards"}->[$i] eq $last) {
                my $j = $numCards - $i;
                while ($j > 0) {
                    my $card = pop @{$self->{"cards"}};
                    push @ret, $card;
                    $j = $j - 1;
                }
                last;
            }
        }
    }

    return \@ret;
}

# Show the cards on the cards stack.
# Params: obj ref.
sub showCards {
	my $self = shift @_;
    my $first = 1;
    for my $card (@{$self->{"cards"}}) {
        if ($first) {
            $first = 0;
            print $card;
        } else {
            print " ".$card;
        }
    }
    print "\n";

    return 1;
}

# Start a new game.
# Params: obj ref.
sub startGame {
    my $self = shift @_;

    # Shuffle deck.
    $self->{"deck"}->shuffle();

    # Evenly distribute cards.
    my $numPlayers = @{$self->{"players"}};
    my @piles = $self->{"deck"}->AveDealCards($numPlayers);
    for my $i (0..$#piles) {
        $self->{"players"}->[$i]->getCards($piles[$i]);
    }

    # Announce players' names.
    print "There $numPlayers players in the game:\n";
    for my $player (@{$self->{"players"}}) {
        print $player->{"name"}." ";
    }
    print "\n\n";
    
    print "Game begin!!!\n\n";

    # Start the game loop.
    my $gameEnded = 0;
    my $currPlayerIdx = 0;
    my $currRound = 1;
    while ($gameEnded == 0) {
        my $player = $self->{"players"}->[$currPlayerIdx];

        # Before deal.
        print "Player ".$player->{"name"}." has ".$player->numCards()." cards before deal.\n";
        
        print "=====Before player's deal=======\n";
        $self->showCards();
        print "================================\n";
        
        # Deal.
        my $cardDealt = $player->dealCards();
        print $player->{"name"}." ==> card ".$cardDealt."\n";
        push @{$self->{"cards"}}, $cardDealt;

        # Check if the player should take some cards back.
        my $retCards = $self->getReturn();
        $player->getCards($retCards);

        # After deal.
        print "=====After player's deal=======\n";
        $self->showCards();
        print "================================\n";

        print "Player ".$player->{"name"}." has ".$player->numCards()." cards after deal.\n";

        # Check if the player is out.
        if ($player->numCards() == 0) {
            print "Player ".$player->{"name"}." has no cards, out!\n";
            splice @{$self->{"players"}}, $currPlayerIdx, 1;
        } else {
            $currPlayerIdx = $currPlayerIdx + 1;
        }

        # Increment the round count.
        if ($currPlayerIdx == @{$self->{"players"}}) {
            $currRound = $currRound + 1;
            $currPlayerIdx = 0;
        }

        # Check if the game should end.
        if (@{$self->{"players"}} == 1) {
            $gameEnded = 1;
        }

        print "\n";
    }

    print "Winner is ".$self->{"players"}->[0]->{"name"}." in game ".$currRound."\n";

}

return 1;