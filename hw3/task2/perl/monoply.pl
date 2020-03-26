#! /usr/bin/perl
use warnings;
use strict;
require "./Bank.pm";
require "./Jail.pm";
require "./Land.pm";
require "./Player.pm";

our @game_board = (
    new Bank(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Jail(),
    new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(),
    new Jail(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Jail(),
    new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(),
);
our $game_board_size = @game_board;

our @players = (new Player("A"), new Player("B"));
our $num_players = @players;

our $cur_player_idx = 0;
our $cur_player = $players[$cur_player_idx];
our $cur_round = 0;
our $max_rounds = 100;
our $num_dices = 1;

srand(0); # don't touch

# game board printing utility. Used to show player position.
sub printCellPrefix {
    my $position = shift;
    my @occupying = ();
    foreach my $player (@players) {
        if ($player->{position} == $position && $player->{money} > 0) {
            push(@occupying, ($player->{name}));
        }
    }
    print(" " x ($num_players - scalar @occupying), @occupying);
    if (scalar @occupying) {
        print("|");
    } else {
        print(" ");
    }
}

sub printGameBoard {
    print("-"x (10 * ($num_players + 6)), "\n");
    for (my $i = 0; $i < 10; $i += 1) {
        printCellPrefix($i);
        $game_board[$i]->print();
    }
    print("\n\n");
    for (my $i = 0; $i < 8; $i += 1) {
        printCellPrefix($game_board_size - $i - 1);
        $game_board[-$i-1]->print();
        print(" "x (8 * ($num_players + 6)));
        printCellPrefix($i + 10);
        $game_board[$i+10]->print();
        print("\n\n");
    }
    for (my $i = 0; $i < 10; $i += 1) {
        printCellPrefix(27 - $i);
        $game_board[27-$i]->print();
    }
    print("\n");
    print("-"x (10 * ($num_players + 6)), "\n");
}

sub termination_check {

    # ...

}

sub throwDice {
    my $step = 0;
    for (my $i = 0; $i < $num_dices; $i += 1) {
        $step += 1 + int(rand(6));
    }
    return $step;
}

sub main {
    while (termination_check()){
        printGameBoard();
        foreach my $player (@players) {
            $player->printAsset();
        }

        # ...

    }
}

main();